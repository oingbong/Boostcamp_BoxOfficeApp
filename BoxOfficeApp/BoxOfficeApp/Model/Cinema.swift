//
//  Cinema.swift
//  BoxOfficeApp
//
//  Created by oingbong on 16/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class Cinema {
    static let shared = Cinema()
    
    var movies: Movies?
    
    public func parse(with orderType: Int) {
        Parser.jsonUrl(with: String(orderType), type: .orderType) { (items) in
            guard let movieItem: Movies = Parser.decode(from: items) else { return }
            self.movies = movieItem
            let key = Notification.Name("updateItem")
            NotificationCenter.default.post(name: key, object: nil)
        }
    }
    
    public func orderType() -> Int {
        return self.movies?.orderType ?? -1
    }
}
