//
//  File.swift
//  RPA-P
//
//  Created by 이주성 on 8/17/24.
//

import Foundation

final class User {
    static let shared = User()
    
    var accessToken: String = ""
    
    private init() {
        
    }
}

// MARK: Firebase
struct UserData {
    struct Firestore {
        static let collectionName = Server.server.firebaseServerURL
        static let fcmTokenField = "fcmToken"
        static let phoneNumberField = "phoneNumber"
        static let uidField = "uid"
        
        static let isCompletetdDepostField = "isCompletedDeposit"
        static let tourIdField = "tourId"
        static let placeNameField = "placeName"
        static let nameField = "name"
        static let bankField = "bank"
    }
}
