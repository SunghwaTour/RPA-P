//
//  ReferenceValues.swift
//  RPA-P
//
//  Created by 이주성 on 7/10/24.
//

import UIKit

struct ReferenceValues {
    static weak var keyWindow: UIWindow!
    
    static weak var firstVC: SplashViewController?
    
    static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var appMark: String {
        var appMark: String!
        
//        switch ServerSetting.server {
//        case .DEV:
//            appMark = "DEV"
//
//        case .QA:
//            appMark = "QA"
//
//        case .RELEASE:
//            appMark = ""
//        }
        
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String,
              let build = dictionary["CFBundleVersion"] as? String else {return appMark + " v(?)"}
        
        return appMark + " v\(version)(\(build))"
    }
    
    // 앱 최초 실행 여부: false(최초 실행), true(최초 실행 아님)
    static var isLaunchedBefore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLaunchedBefore")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "isLaunchedBefore")
        }
    }
    
    // 앱 권한 처리 화면 표시 여부: false(표시), true(미표시)
    static var isCheckPermission: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isCheckPermission")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "isCheckPermission")
        }
    }
    
    // FCMToken
    static var fcmToken: String {
        get {
            return UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "fcmToken")
        }
    }
    
    // 전화번호 인증을 통해 얻은 UID
    static var uid: String {
        get {
            return UserDefaults.standard.string(forKey: "uid") ?? "null"
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "uid")
        }
    }
    
    static var phoneNumber: String {
        get {
            return UserDefaults.standard.string(forKey: "phoneNumber") ?? "null"
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "phoneNumber")
        }
    }
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: "name") ?? "null"
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "name")
        }
    }
    
    static var useCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "useCount")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "useCount")
        }
    }
    
    // FIXME: 서버와 약속에 따라서 String 바꿔주기
    static let expiredConditionMessage: String = "다른 기기에서 로그인 되었습니다."
    
    // MARK: 카카오 키
    static let kakaoAuthKey = "KakaoAK a9ae68eace6999d4b0d87a0424f20836"
    
    // MARK: Basic Price
    static let basicPrice = 692000
    
    // MARK: One Night Price
    static let pricePerOneNight = 692000
    
}

// MARK: - Extension of referenceValues
extension ReferenceValues {
    // 디바이스 크기
    struct Size {
        struct Device {
            static let width: CGFloat = ReferenceValues.keyWindow.screen.bounds.width
            static let height: CGFloat = ReferenceValues.keyWindow.screen.bounds.height
        }
        
        struct SafeAreaInsets {
            static let top: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.top
            static let bottom: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.bottom
            static let left: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.left
            static let right: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.right
        }
        
        struct Ratio {
            static let bannerHeightRatio: CGFloat = 100/343
        }
    }
    
    struct Velocity {
        static let hideBottomView: CGFloat = 650
    }
    
    // 글자 수 제한
    struct TextCount {
        struct Comment {
            static let comment: Int = 150
            static let subComment: Int = 150
        }
        
        struct Message {
            static let message: Int = 403
        }
        
        struct Travel {
            static let newPlaceName: Int = 20
            static let newPathName: Int = 30
            static let newPlaceDescription: Int = 300
            static let suggestWrite: Int = 650
            static let waitCount: Int = 3
            static let waitDescription: Int = 40
        }
    }
}
