//
//  OrderType.swift
//  BoxOfficeApp
//
//  Created by oingbong on 16/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

enum OrderType: Int, CustomStringConvertible {
    case rate = 0, curation, date
    
    var description: String {
        switch self {
        case .rate: return "예매율"
        case .curation: return "큐레이션"
        case .date: return "개봉일"
        }
    }
    
    static func selected(with word: String) -> Int {
        switch word {
        case OrderType.rate.description: return 0
        case OrderType.curation.description: return 1
        case OrderType.date.description: return 2
        default: return -1
        }
    }
}
