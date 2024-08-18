//
//  MainModel.swift
//  RPA-P
//
//  Created by 이주성 on 7/16/24.
//

import Foundation
import Alamofire
import FirebaseFirestore

final class MainModel {
    // MARK: Server
    private(set) var getTokenRequest: DataRequest?
    private(set) var sendEstimateDataRequest: DataRequest?
    private(set) var sendConfirmReservationRequest: DataRequest?
    private(set) var getContractRequest: DataRequest?
    
    // MARK: Firebase
    private var db = Firestore.firestore()
    
    private(set) var getEstimateData: DataRequest?
    
    // MARK: Kakao requests
    private(set) var findKeywordWithTextRequest: DataRequest?
    private(set) var searchAddressWithTextReqeust: DataRequest?
    private(set) var searchDurationRequest: DataRequest?
    
    private(set) var searchedAddress: SearchedAddress = SearchedAddress()
    
    // MARK: Server
    func getTokenRequest(success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/login"
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
//            "Authorization": User.shared.accessToken
        ]
        
        let parameters: Parameters = [
            "user_id": "rpap",
            "password": "kingbus12!@",
        ]
        
        self.getTokenRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.getTokenRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("getTokenRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("getTokenRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Token.self, from: data) {
                    
                    print("getTokenRequest accessToekn: \(decodedData.data.access)")
                    print("getTokenRequest succeeded")
                    User.shared.accessToken = "Bearer \(decodedData.data.access)"
                    success?()
                    
                } else {
                    print("getTokenRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                    
                }
                
            case .failure(let error):
                print("getTokenRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendEstimateDataRequest(estimate: PreEstimate, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/estimate"
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization": User.shared.accessToken
        ]
        
        let parameters: Parameters = [
            "uid": ReferenceValues.uid,
            "kindsOfEstimate": estimate.kindsOfEstimate.rawValue,
            "departure": [
                "index" : estimate.departure.index,
                "latitude" : Double(estimate.departure.latitude)!,
                "longitude" : Double(estimate.departure.longitude)!,
                "address" : estimate.departure.address,
                "name" : estimate.departure.name,
                "type" : estimate.departure.type
            ],
            "arrival": [
                "index" : estimate.return.index,
                "latitude" : Double(estimate.return.latitude)!,
                "longitude" : Double(estimate.return.longitude)!,
                "address" : estimate.return.address,
                "name" : estimate.return.name,
                "type" : estimate.return.type
            ],
            "stopover": estimate.stopover == nil ? [] : [[
                "index" : estimate.stopover!.index,
                "latitude" : Double(estimate.stopover!.latitude)!,
                "longitude" : Double(estimate.stopover!.longitude)!,
                "address" : estimate.stopover!.address,
                "name" : estimate.stopover!.name,
                "type" : estimate.stopover!.type
            ]
            ],
            "distance": estimate.distance,
            "duration": estimate.duration, // 분
            "departureDate": estimate.departureDate.dateForServer(),
            "arrivalDate": estimate.returnDate.dateForServer(),
            "number": estimate.number == nil ? "미정" : String(estimate.number!),
            "busCount": "\(estimate.busCount)",
            "payWay": estimate.pay!.payWay!.rawValue,
            "signedName": estimate.pay!.signedName,
            "price": "\(estimate.virtualEstimate?.price ?? 0)",
            "busType": estimate.busType?.rawValue ?? "47인승",
            "operationType": estimate.virtualEstimate?.category[0].rawValue ?? "단순 기사 동행", // 기사동행여부
            "isCompletedReservation": false,
            "isConfirmedReservation": false,
            "isPriceChange": false,
            "isEstimateApproval": false,
            "departureIndex": estimate.departureDate.returnDepartureIndex(),
            "phone": ReferenceValues.phoneNumber
        ]
        
        self.sendEstimateDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendEstimateDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendEstimateDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendEstimateDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    print("sendEstimateDataRequest succeeded")
                    print(decodedData.result)
                    success?()
                    
                } else {
                    print("sendEstimateDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("sendEstimateDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendConfirmReservationRequest(estimateId: String, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/estimate/reservation/confirm"
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization": User.shared.accessToken
        ]
        
        let parameters: Parameters = [
            "userUid": ReferenceValues.uid,
            "estimateUid": estimateId,
        ]
        
        self.sendConfirmReservationRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendConfirmReservationRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendConfirmReservationRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendConfirmReservationRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    print("sendConfirmReservationRequest succeeded")
                    print(decodedData.result)
                    success?()
                    
                } else {
                    print("sendConfirmReservationRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("sendConfirmReservationRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func getContractRequest(estimateUid: String, success: ((String) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/estimate/contract"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": User.shared.accessToken
        ]
        
        var parameters: Parameters = [
            "estimateUid": estimateUid,
        ]
        
        self.getContractRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.getContractRequest?.responseString { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("getContractRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("getContractRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                success?(data)
                
            case .failure(let error): // error
                print("getContractRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
            
        }
        
    }
    
    // MARK: Firebase
    func getEstimateData(success: (([Estimate]) -> ())?, failure: ((String) -> ())?) {
        let uid = ReferenceValues.uid
        
        if uid == "null" {
            failure?("전화번호 인증 필요.")
        } else {
            self.db.collection("\(Server.server.firebaseServerURL)/User/\(uid)/Estimate").order(by: "departureIndex").addSnapshotListener { querySnapshot, error in
                if let error = error {
                    failure?("getEstimateData Error: \(error.localizedDescription)")
                    
                } else {
                    guard let querySnapshot = querySnapshot else {
                        failure?("getEstimateData Error: Empty Data")
                        return
                    }
                    
                    for document in querySnapshot.documents {
                        print(document.documentID)
                    }
                    
                    let esimates: [Estimate] = querySnapshot.documents.compactMap { doc -> Estimate? in
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                            var estimate = try JSONDecoder().decode(Estimate.self, from: jsonData)
                            estimate.documentId = doc.documentID
                            
                            return estimate
                            
                        } catch let error {
                            failure?(error.localizedDescription)
                            return nil
                            
                        }
                        
                    }
                    
                    querySnapshot.documentChanges.forEach { change in
                        switch change.type {
                        case .added:
                            print("added")
                        case .modified:
                            print("modified")
                        case .removed:
                            print("removed")
                        }
                    }
                    
                    success?(esimates)
                    
                }
                
            }
            
        }
        
    }
    
}

// MARK: Server
struct DefaultResponse: Codable {
    let result: String
}

struct Token: Codable {
    let data: TokenItem
}

struct TokenItem: Codable {
    let access: String
}

// MARK: Estimate
enum Category: String, Codable {
    case general = "일반"
    case honor = "우등"
    case full = "전체 기사 동행"
    case partial = "단순 기사 동행"
    
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

enum BusType: String, Codable {
    // 25/33/43/47
    case twentyFive = "25인승"
    case thirtyThree = "33인승"
    case fortyThree = "43인승"
    case fortySeven = "47인승"
    
    var number: Int {
        switch self {
        case .twentyFive:
            return 25
        case .thirtyThree:
            return 33
        case .fortyThree:
            return 43
        case .fortySeven:
            return 47
        }
    }
}

struct PreEstimate: Codable {
    var kindsOfEstimate: KindsOfEstimate
    var departure: EstimateAddress
    var `return`: EstimateAddress
    var stopover: EstimateAddress? = nil
    var departureDate: EstimateTime
    var returnDate: EstimateTime
    var number: Int?
    var pay: Pay?
    var distance: Int
    var duration: Int
    var busType: BusType?
    var busCount: Int
    
    var virtualEstimate: VirtualEstimate? = nil
}

struct EstimateAddress: Codable {
    var index: Int = 2
    var name: String = "경유지 없음"
    var address: String = ""
    var latitude: String = "0"
    var longitude: String = "0"
    var type: String = "경유지"
}

struct EstimateTime: Codable {
    var date: String = ""
    var time: String = ""
    
    func dateForServer() -> String {
        let dateForConverting = SupportingMethods.shared.convertString(intoDate: self.date, "yyyy.MM.dd")
        let splitTime = self.time.split(separator: " ")
        var changedTime: String = ""
        
        if splitTime[1] == "오후" {
            changedTime = "\(Int(splitTime[0].split(separator: ":")[0])! + 12):" + splitTime[0].split(separator: ":")[1]
        } else {
            changedTime = "\(splitTime[0])"
        }
        
        let dateForServer = SupportingMethods.shared.convertDate(intoString: dateForConverting, "yyyy-MM-dd") + " \(changedTime)"
        
        return dateForServer
    }
    
    func returnDepartureIndex() -> String {
        let fullDate = SupportingMethods.shared.convertString(intoDate: self.dateForServer(), "yyyy-MM-dd HH:mm")
        let departureIndex = SupportingMethods.shared.convertDate(intoString: fullDate, "yyyyMMddHHmm")
        
        return departureIndex
    }
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

// MARK: Firebase Model
struct Estimate: Codable {
    var documentId: String = "" // 견적 uid
    let kindsOfEstimate: String // 왕복, 편도, 셔틀
    let departure: String // 출발지
    let arrival: String // 도착지
    let distance: Int //거리
    let duration: Double // 출발지에서 도착지까지의 시간
    let stopover: [String] // 경유지 ([수원, 서울])
    let departureDate: String // 출발날짜시간(yyyy-MM-dd HH:mm)
    let arrivalDate: String // 도착날짜시간(yyyy-MM-dd HH:mm)
    let number: String // 인원수
    let busCount: String // 버스대수
    let payWay: String // 결제방식 (현금, 카드, 계좌이체)
    let signedName: String // 이름
    let price: String // 가격
    let busType: String // 차량종류
    let operationType: String // 운행종류
    let isCompletedReservation: Bool // 운행 확정시 true
    let isConfirmedReservation: Bool // 예약 확정시 true
    let isEstimateApproval: Bool // trp에서 배차시 true(해당 값이 true면 예약 확정하기 버튼 활성화)
    let isPriceChange: Bool // 가격 변경시 true
    let departureIndex: String // 출발시간값 인덱스 (202408101012)
    let phone: String // 휴대폰 번호
    
    enum CodingKeys: CodingKey {
        case kindsOfEstimate
        case departure
        case arrival
        case distance
        case duration
        case stopover
        case departureDate
        case arrivalDate
        case number
        case busCount
        case payWay
        case signedName
        case price
        case busType
        case operationType
        case isCompletedReservation
        case isConfirmedReservation
        case isEstimateApproval
        case isPriceChange
        case departureIndex
        case phone
    }
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
    
    func searchDurationRequest(origin: EstimateAddress, destination: EstimateAddress, success: ((DirectionSummary) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = "https://apis-navi.kakaomobility.com/v1/directions"
        
        let headers: HTTPHeaders = [
            "Authorization": ReferenceValues.kakaoAuthKey,
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "origin": "\(origin.longitude),\(origin.latitude)",
            "destination": "\(destination.longitude),\(destination.latitude)",
        ]
        
        self.searchDurationRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.searchDurationRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("searchDurationRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("searchDurationRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Direction.self, from: data) {
                    print("sendEstimateDataRequest succeeded")
                    success?(decodedData.routes[0].summary)
                    
                } else {
                    print("sendEstimateDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("searchDurationRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
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

struct Direction: Codable {
    let transId: String
    let routes: [DirectionRoutes]
    
    enum CodingKeys: String, CodingKey {
        case transId = "trans_id"
        case routes
    }
}

struct DirectionRoutes: Codable {
    let summary: DirectionSummary
}

struct DirectionSummary: Codable {
    let duration: Int
}
