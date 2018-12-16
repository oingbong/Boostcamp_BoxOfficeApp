//
//  Cinema.swift
//  BoxOfficeApp
//
//  Created by oingbong on 16/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

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
    
    func parse(with orderType: Int, viewController: UIViewController) {
        Parser.jsonUrl(with: String(orderType), type: .orderType, vc: viewController) { (items) in
            guard let movieItem: Movies = Parser.decode(from: items) else {
                self.errorAlert(with: viewController)
                return
            }
            self.movies = movieItem
            let key = Notification.Name("updateItem")
            NotificationCenter.default.post(name: key, object: nil)
        }
    }
    
    func parseDetail(with movieId: String, viewController: UIViewController) {
        let key = Notification.Name("updateItemDetail")
        
        Parser.jsonUrl(with: movieId, type: .id, vc: viewController ) { (item) in
            guard let movieItem: Movie = Parser.decode(from: item) else {
                self.errorAlert(with: viewController)
                return
            }
            self.selectedMovie = movieItem
            NotificationCenter.default.post(name: key, object: nil)
        }
        
        Parser.jsonUrl(with: movieId, type: .comment, vc: viewController) { (item) in
            guard let movieEvaluations: MovieEvaluations = Parser.decode(from: item) else {
                self.errorAlert(with: viewController)
                return
            }
            self.movieEvaluations = movieEvaluations
            NotificationCenter.default.post(name: key, object: nil)
        }
    }
    
    private func errorAlert(with vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: "데이터를 받는 도중 에러가 발생하였습니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "어쩔 수 없죠...", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
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
