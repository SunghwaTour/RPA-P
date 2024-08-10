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
                return "34.121.50.23"
                
            case .QA:
                return ""
                
            case .RELEASE:
                return ""
            }
        }
        
        var imageServerFactor: String {
            switch self {
            case .DEV:
                return "dev"
                
            case .QA:
                return "qa"
                
            case .RELEASE:
                return "prod"
            }
        }
        
    }
}
