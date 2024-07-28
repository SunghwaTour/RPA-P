//
//  MainModel.swift
//  RPA-P
//
//  Created by 이주성 on 7/16/24.
//

import Foundation
import RealmSwift
import Alamofire

class FullData: Object {
    @objc dynamic var id = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class MainModel {
    // MARK: Kakao requests
    private(set) var findKeywordWithTextRequest: DataRequest?
    private(set) var searchAddressWithTextReqeust: DataRequest?
    
    private(set) var searchedAddress: SearchedAddress = SearchedAddress()
    
}

// MARK: Estimate
enum Category: String, Codable {
    case general = "일반"
    case honor = "우등"
    case full = "전체 기사 동행"
    case partial = "부분 기사 동행"
    
    var kindsNumber: Int {
        switch self {
        case .general:
            return 0
        case .honor:
            return 0
        case .full:
            return 1
        case .partial:
            return 1
        }
    }
    
    var price: Int {
        switch self {
        case .general:
            return 0
        case .honor:
            return 150000
        case .full:
            return 150000
        case .partial:
            return 0
        }
    }
}

enum KindsOfEstimate: String, Codable {
    case roundTrip = "왕복"
    case oneWay = "편도"
    case shuttle = "셔틀"
    
    var discountRate: Double {
        switch self {
        case .roundTrip:
            return 1.0
        case .oneWay:
            return 0.8
        case .shuttle:
            return 0
        }
    }
}

enum PayWay: String, Codable {
    case cash = "현금"
    case card = "카드"
    case account = "계좌이체"
    
    var label: String {
        switch self {
        case .cash:
            return "만나서 현금결제"
        case .card:
            return "만나서 카드결제"
        case .account:
            return "계좌이체"
        }
    }
}

struct Estimate: Codable {
    var kindsOfEstimate: KindsOfEstimate
    var departure: EstimateAddress
    var `return`: EstimateAddress
    var stopover: EstimateAddress? = nil
    var departureDate: EstimateTime
    var returnDate: EstimateTime
    var number: Int?
    var pay: Pay?
    
    var virtualEstimate: VirtualEstimate? = nil
}

struct EstimateAddress: Codable {
    var name: String = ""
    var latitude: String = ""
    var longitude: String = ""
}

struct EstimateTime: Codable {
    var date: String = ""
    var time: String = ""
}

struct VirtualEstimate: Codable {
    let no: Int
    let category: [Category]
    var price: Int
    
}

struct Pay: Codable {
    var payWay: PayWay?
    var signedName: String = ""
}

// MARK: - Kakao API
extension MainModel {
    private func findKeywordWithTextRequest(_ text: String, page: Int, success: ((KeywordResult) -> ())?, failure: ((String) -> ())?) {
        let url = "https://dapi.kakao.com/v2/local/search/keyword.json"
        
        let headers: HTTPHeaders = [
            "Authorization":ReferenceValues.kakaoAuthKey
        ]
        
        let parameters: Parameters = [
            "query":text, // 검색을 원하는 질의어
            "page":page, // 결과 페이지 번호: 1~45 사이의 값 (기본값: 1)
        ]
        
        self.findKeywordWithTextRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.findKeywordWithTextRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("findKeywordWithTextRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("findKeywordWithTextRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(KeywordResult.self, from: data) {
                    print("findKeywordWithTextRequest succeeded")
                    success?(decodedData)
                    
                } else {
                    print("findKeywordWithTextRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("findKeywordWithTextRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    private func searchAddressWithTextReqeust(_ text: String, page: Int, success: ((CompanyAddress) -> ())?, failure: ((String) -> ())?) {
        let url = "https://dapi.kakao.com/v2/local/search/address.json"
        
        let headers: HTTPHeaders = [
            "Authorization":ReferenceValues.kakaoAuthKey
        ]
        
        let parameters: Parameters = [
            "query":text, // 검색을 원하는 질의어
            "analyze":"similar",
            // similar: 입력한 건물명과 일부만 매칭될 경우에도 확장된 검색 결과 제공, 미지정 시 similar가 적용됨
            // exact: 주소의 정확한 건물명이 입력된 주소패턴일 경우에 한해, 입력한 건물명과 정확히 일치하는 검색 결과 제공
            "page":page, // 결과 페이지 번호: 1~45 사이의 값 (기본값: 1)
            "size":20 // 한페이지에 보여질 문서의 개수: 1~30 사이의 값(기본값: 10)
        ]
        
        self.searchAddressWithTextReqeust = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.searchAddressWithTextReqeust?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("searchAddressWithTextReqeust failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("searchAddressWithTextReqeust failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(CompanyAddress.self, from: data) {
                    print("searchAddressWithTextReqeust succeeded")
                    success?(decodedData)
                    
                } else {
                    print("searchAddressWithTextReqeust failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("searchAddressWithTextReqeust error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func initializeModel() {
        self.searchedAddress = SearchedAddress()
    }
    
    func searchAddressWithText(_ text: String, success: (() -> ())?, failure: ((String) -> ())?) {
        switch self.searchedAddress.searchingType {
        case .keyword:
            self.searchedAddress.keywordSearchingPage += 1
            self.findKeywordWithTextRequest(text, page: self.searchedAddress.keywordSearchingPage) { keywordResult in
                self.searchedAddress = self.convertKeywordResultDocument(keywordResult, into: self.searchedAddress)
                
                if keywordResult.meta.isEnd {
                    self.searchedAddress.searchingType = .address
                    self.searchedAddress.addressSearchingPage += 1
                    
                    self.searchAddressWithTextReqeust(text, page: self.searchedAddress.addressSearchingPage) { companyAddress in
                        self.searchedAddress = self.convertCompanyAddressDocument(companyAddress, into: self.searchedAddress)
                        success?()
                        
                    } failure: { errorMessage in
                        failure?(errorMessage)
                    }
                    
                } else {
                    success?()
                }
                
            } failure: { errorMessage in
                failure?(errorMessage)
            }
            
        case .address:
            self.searchedAddress.addressSearchingPage += 1
            self.searchAddressWithTextReqeust(text, page: self.searchedAddress.addressSearchingPage) { companyAddress in
                self.searchedAddress = self.convertCompanyAddressDocument(companyAddress, into: self.searchedAddress)
                success?()
                
            } failure: { errorMessage in
                failure?(errorMessage)
            }
        }
    }
    
    func convertKeywordResultDocument(_ keywordResult: KeywordResult, into searchedAddress: SearchedAddress) -> SearchedAddress {
        searchedAddress.isKeywordEnd = keywordResult.meta.isEnd
        
        for document in keywordResult.documents {
            let address = SearchedAddress.Address(placeName: document.placeName == "" ? nil : document.placeName,
                                                  jibeonAddress: document.addressName == "" ? nil : document.addressName,
                                                  roadAddress: document.roadAddressName == "" ? nil : document.roadAddressName,
                                                  latitude: document.latitude,
                                                  longitude: document.longitude)
            searchedAddress.address.append(address)
        }
        
        return searchedAddress
    }
    
    func convertCompanyAddressDocument(_ companyAddress: CompanyAddress, into searchedAddress: SearchedAddress) -> SearchedAddress {
        searchedAddress.isAddressEnd = companyAddress.meta.isEnd
        
        for document in companyAddress.documents {
            let address = SearchedAddress.Address(placeName: nil,
                                                  jibeonAddress: document.address?.addressName,
                                                  roadAddress: document.roadAddress?.addressName,
                                                  latitude: document.latitude,
                                                  longitude: document.longitude)
            
            searchedAddress.address.append(address)
        }
        
        return searchedAddress
    }
}

class SearchedAddress {
    enum SearchingType {
        case keyword
        case address
    }
    
    fileprivate var searchingType: SearchingType = .keyword
    fileprivate var keywordSearchingPage: Int = 0
    fileprivate var addressSearchingPage: Int = 0
    fileprivate var isKeywordEnd: Bool = false
    fileprivate(set) var isAddressEnd: Bool = false
    var address: [Address] = []
    
    struct Address {
        let placeName: String?
        let jibeonAddress: String?
        let roadAddress: String?
        let latitude: String
        let longitude: String
    }
}

struct KeywordResult: Codable {
    let meta: Meta
    let documents: [Document]
    
    struct Meta: Codable {
        let totalCount: Int // 검색어에 검색된 문서 수
        let pageableCount: Int // total_count 중 노출 가능 문서 수 (최대값: 45?)
        let isEnd: Bool // 현재 페이지가 마지막 페이지인지 여부, 값이 false이면 page를 증가시켜 다음 페이지 요청 가능
        let regionInfo: RegionInfo // 질의어의 지역 및 키워드 분석 정보
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case pageableCount = "pageable_count"
            case isEnd = "is_end"
            case regionInfo = "same_name"
        }
        
        struct RegionInfo: Codable {
            let region: [String] // 질의어에서 인식된 지역의 리스트, 예: '중앙로 맛집' 에서 중앙로에 해당하는 지역 리스트
            let keyword: String // 질의어에서 지역 정보를 제외한 키워드, 예: '중앙로 맛집' 에서 '맛집'
            let selectedRegion: String // 인식된 지역 리스트 중, 현재 검색에 사용된 지역 정보
            
            enum CodingKeys: String, CodingKey {
                case region
                case keyword
                case selectedRegion = "selected_region"
            }
        }
    }
    
    struct Document: Codable {
        let id: String // 장소 ID
        let placeName: String // 장소명, 업체명
        let categoryName: String // 카테고리 이름
        let categoryGroupCode: String // 중요 카테고리만 그룹핑한 카테고리 그룹 코드
        let categoryGroupName: String // 중요 카테고리만 그룹핑한 카테고리 그룹명
        let phone: String // 전화번호
        let addressName: String // 전체 지번 주소
        let roadAddressName: String // 전체 도로명 주소
        let latitude: String // Y 좌표값, 경위도인 경우 latitude(위도)
        let longitude: String // X 좌표값, 경위도인 경우 longitude (경도)
        let placeUrl: String // 장소 상세페이지 URL
        let distance: String // 중심좌표까지의 거리 (단, x,y 파라미터를 준 경우에만 존재), 단위 meter
        
        enum CodingKeys: String, CodingKey {
            case id
            case placeName = "place_name"
            case categoryName = "category_name"
            case categoryGroupCode = "category_group_code"
            case categoryGroupName = "category_group_name"
            case phone
            case addressName = "address_name"
            case roadAddressName = "road_address_name"
            case latitude = "y"
            case longitude = "x"
            case placeUrl = "place_url"
            case distance
        }
    }
}

struct CompanyAddress: Codable {
    var documents: [Document]
    var meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case documents
        case meta
    }
    
    struct Document: Codable {
        var addressName: String // 전체 지번 주소 또는 전체 도로명 주소, 입력에 따라 결정됨
        var addressType: String // address_name의 값의 타입(Type)
                                //REGION(지명), ROAD(도로명), REGION_ADDR(지번 주소), ROAD_ADDR (도로명 주소) 중 하나
        var longitude: String // X 좌표값 (경도)
        var latitude: String // Y 좌표값 (위도)
        var address: Address? // 지번 주소 상세 정보, 아래 address 항목 구성 요소 참고
        var roadAddress: RoadAddress? // 도로명 주소 상세 정보, 아래 RoadAaddress 항목 구성 요소 참고
        
        enum CodingKeys: String, CodingKey {
            case addressName = "address_name"
            case addressType = "address_type"
            case longitude = "x"
            case latitude = "y"
            case address
            case roadAddress = "road_address"
        }
        
        struct Address: Codable {
            var addressName: String // 전체 지번 주소
            var stateOrCityName: String // 지역 1 Depth, 시도 단위
            var cityOrGuName: String // 지역 2 Depth, 구 단위
            var guOrDongName: String // 지역 3 Depth, 동 단위
            var dongName: String // 지역 3 Depth, 행정동 명칭
            var hCode: String // 행정 코드
            var bCode: String // 법정 코드
            var mountainYN: String // 산 여부, Y 또는 N
            var mainAddressNumber: String // 지번 주번지
            var subAddressNumber: String // 지번 부번지. 없을 경우 ""
            //var zipCode: String // Deprecated 우편번호(6자리)
            var longitude: String // X 좌표값
            var latitude: String // Y 좌표값
            
            enum CodingKeys: String, CodingKey {
                case addressName = "address_name"
                case stateOrCityName = "region_1depth_name"
                case cityOrGuName = "region_2depth_name"
                case guOrDongName = "region_3depth_name"
                case dongName = "region_3depth_h_name"
                case hCode = "h_code"
                case bCode = "b_code"
                case mountainYN = "mountain_yn"
                case mainAddressNumber = "main_address_no"
                case subAddressNumber = "sub_address_no"
                //case zipCode = "zip_code"
                case longitude = "x"
                case latitude = "y"
            }
        }

        struct RoadAddress: Codable {
            var addressName: String // 전체 도로명 주소
            var firstRegionName: String // 지역명1
            var secondRegionName: String // 지역명2
            var thirdRegionName: String // 지역명3
            var roadName: String // 도로명
            var undergroundYN: String // 지하 여부, Y 또는 N
            var mainBuildingNumber: String // 건물 본번
            var subBuildingNumber: String // 지번 부번지. 없을 경우 ""
            var buildingName: String // 건물 이름
            var zoneNumber: String // 우편번호(5자리)
            var longitude: String // X 좌표값
            var latitude: String // Y 좌표값
            
            enum CodingKeys: String, CodingKey {
                case addressName = "address_name"
                case firstRegionName = "region_1depth_name"
                case secondRegionName = "region_2depth_name"
                case thirdRegionName = "region_3depth_name"
                case roadName = "road_name"
                case undergroundYN = "underground_yn"
                case mainBuildingNumber = "main_building_no"
                case subBuildingNumber = "sub_building_no"
                case buildingName = "building_name"
                case zoneNumber = "zone_no"
                case longitude = "x"
                case latitude = "y"
            }
        }
    }
    
    struct Meta: Codable {
        var totalCount: Int // 검색어에 검색된 문서 수
        var pageableCount: Int // total_count 중 노출 가능 문서 수 (최대값: 45?)
        var isEnd: Bool // 현재 페이지가 마지막 페이지인지 여부, 값이 false이면 page를 증가시켜 다음 페이지 요청 가능
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case pageableCount = "pageable_count"
            case isEnd = "is_end"
        }
    }
}

