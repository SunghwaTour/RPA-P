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
