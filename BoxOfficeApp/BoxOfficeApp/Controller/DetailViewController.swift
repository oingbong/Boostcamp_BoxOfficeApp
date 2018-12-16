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
    var id: String? // from Table / Collection View (not private)
    private var cinema = Cinema.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        tableview.dataSource = self
        configure()
    }
    
    private func configure() {
        guard let movieId = id else { return }
        cinema.parseDetail(with: movieId)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinema.movieEvaluationsCount + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = cinema.selectedMovie else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero)) }
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
                guard let items = cinema.evaluationsSubscript(index: indexPath.row - 3) else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))}
                cell.configure(from: items)
                return cell
            }
        }
        return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))
    }
}

extension DetailViewController {
    private func configureObservers() {
        let key = Notification.Name("updateItemDetail")
        NotificationCenter.default.addObserver(self, selector: #selector(updateItemDetail), name: key, object: nil)
    }
    
    @objc private func updateItemDetail() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}
