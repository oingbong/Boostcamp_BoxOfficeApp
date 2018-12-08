//
//  Movies.swift
//  BoxOfficeApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    var orderType: Int
    var data: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case orderType = "order_type"
        case data = "movies"
    }
    
    var count: Int {
        return data.count
    }
    
    subscript(index: Int) -> Movie {
        return data[index]
    }
}
