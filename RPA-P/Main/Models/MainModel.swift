//
//  MainModel.swift
//  RPA-P
//
//  Created by 이주성 on 7/16/24.
//

import Foundation

final class MainModel {
    
}

// MARK: Estimate
enum Category: String {
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
}

struct Estimate {
    let no: Int
    let category: [Category]
    let price: String
    
}


