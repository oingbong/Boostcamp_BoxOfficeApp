//
//  DetailViewController.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var id: String?
    var movie: Movie?
    var movieEvaluations: MovieEvaluations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        configure()
    }
    
    private func configure() {
        guard let movieId = id else { return }
        Parser.jsonUrl(with: movieId, type: .id) { (item) in
            guard let movieItem: Movie = Parser.decode(from: item) else { return }
            self.movie = movieItem
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        
        Parser.jsonUrl(with: movieId, type: .comment) { (item) in
            guard let movieEvaluations: MovieEvaluations = Parser.decode(from: item) else { return }
            self.movieEvaluations = movieEvaluations
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieEvaluations?.count ?? 0 + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movie else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero)) }
        switch indexPath.row {
        case 0:
            if let cell = tableview.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell {
                cell.configure(from: movie)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SynopsisCell", for: indexPath) as? SynopsisCell {
                cell.configure(from: movie)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath) as? PeopleCell {
                cell.configure(from: movie)
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell {
                guard let items = movieEvaluations?[indexPath.row] else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))}
                cell.configure(from: items)
                return cell
            }
        }
        
        return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))
    }
}
