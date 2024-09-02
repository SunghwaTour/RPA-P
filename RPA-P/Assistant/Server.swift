//
//  Server.swift
//  RPA-P
//
//  Created by Awesomepia on 8/8/24.
//

import Foundation

struct Server {
    static let server: Server = .DEV
    
    // MARK: DEV v1.0.0 - 2024/08/06
    
    enum Server: String {
        case DEV
        case QA
        case RELEASE
        
        var URL: String {
            switch self {
            case .DEV:
                return "http://34.121.50.23:8000"
                
            case .QA:
                return ""
                
            case .RELEASE:
                return "http://api.kingbuserp.link"
            }
        }
        
        var imageServerFactor: String {
            switch self {
            case .DEV:
                return "Dev"
                
            case .QA:
                return "qa"
                
            case .RELEASE:
                return "Sunghwatour"
            }
        }
        
        var firebaseServerURL: String {
            switch self {
            case .DEV:
                return "/Server/Dev"
            case .QA:
                return ""
            case .RELEASE:
                return "/Server/Sunghwatour"
            }
        }
        
    }
}
