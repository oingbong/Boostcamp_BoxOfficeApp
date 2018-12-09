//
//  SortName.swift
//  BoxOfficeApp
//
//  Created by oingbong on 09/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

enum SortName: Int, CustomStringConvertible {
    case reservationRate
    case curation
    case date
    
    var description: String {
        switch self {
        case .reservationRate: return "예매율"
        case .curation: return "큐레이션"
        case .date: return "개봉일"
        }
    }
    
    func select(from element: Int) -> SortName? {
        switch element {
        case 0: return .reservationRate
        case 1: return .curation
        case 2: return .date
        default: return nil
        }
    }
}
