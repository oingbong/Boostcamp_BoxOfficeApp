//
//  MovieEvaluations.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct MovieEvaluations: Decodable {
    var movieId: String
    var data: [MovieEvaluation]
    
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case data = "comments"
    }
    
    var count: Int {
        return data.count
    }
    
    subscript(index: Int) -> MovieEvaluation {
        return data[index]
    }
}
