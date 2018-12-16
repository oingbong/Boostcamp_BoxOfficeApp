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
    
    private var movies: Movies?
    private var movieEvaluations: MovieEvaluations?
    var selectedMovie: Movie? // for Table, Collection View (not private)
    
    var moviesCount: Int {
        return movies?.count ?? 0
    }
    
    var movieEvaluationsCount: Int {
        return movieEvaluations?.count ?? 0
    }
    
    func parse(with orderType: Int) {
        Parser.jsonUrl(with: String(orderType), type: .orderType) { (items) in
            guard let movieItem: Movies = Parser.decode(from: items) else { return }
            self.movies = movieItem
            let key = Notification.Name("updateItem")
            NotificationCenter.default.post(name: key, object: nil)
        }
    }
    
    func parseDetail(with movieId: String) {
        let key = Notification.Name("updateItemDetail")
        
        Parser.jsonUrl(with: movieId, type: .id) { (item) in
            guard let movieItem: Movie = Parser.decode(from: item) else { return }
            self.selectedMovie = movieItem
            NotificationCenter.default.post(name: key, object: nil)
        }
        
        Parser.jsonUrl(with: movieId, type: .comment) { (item) in
            guard let movieEvaluations: MovieEvaluations = Parser.decode(from: item) else { return }
            self.movieEvaluations = movieEvaluations
            NotificationCenter.default.post(name: key, object: nil)
        }
    }
    
    func orderType() -> Int {
        return self.movies?.orderType ?? -1
    }
    
    subscript(index: Int) -> Movie? {
        return movies?[index]
    }
    
    func evaluationsSubscript(index: Int) -> MovieEvaluation? {
        return movieEvaluations?[index]
    }
}
