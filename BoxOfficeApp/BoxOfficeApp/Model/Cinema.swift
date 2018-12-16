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
            NotificationCenter.default.post(name: NotificationKey.updateItem, object: nil)
        }
    }
    
    func parseDetail(with movieId: String, viewController: UIViewController) {
        Parser.jsonUrl(with: movieId, type: .id, vc: viewController ) { (item) in
            guard let movieItem: Movie = Parser.decode(from: item) else {
                self.errorAlert(with: viewController)
                return
            }
            self.selectedMovie = movieItem
            NotificationCenter.default.post(name: NotificationKey.updateItemDetail, object: nil)
        }
        
        Parser.jsonUrl(with: movieId, type: .comment, vc: viewController) { (item) in
            guard let movieEvaluations: MovieEvaluations = Parser.decode(from: item) else {
                self.errorAlert(with: viewController)
                return
            }
            self.movieEvaluations = movieEvaluations
            NotificationCenter.default.post(name: NotificationKey.updateItemDetail, object: nil)
        }
    }
    
    private func errorAlert(with vc: UIViewController) {
        let alertMessage = "데이터를 받는 도중 에러가 발생하였습니다."
        let actionTitle = "어쩔 수 없죠..."
        let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
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
