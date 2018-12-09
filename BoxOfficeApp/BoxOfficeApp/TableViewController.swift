//
//  ViewController.swift
//  BoxOfficeApp
//
//  Created by oingbong on 05/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var movies: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        appendButtonItem()
        configure(with: 0)
    }
    
    private func appendButtonItem() {
        guard let image = UIImage(named: "ic_settings") else { return }
        let buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(sorted))
        buttonItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    private func configure(with element: Int) {
        parse(orderType: element)
        configureTitle(from: element)
    }
    
    private func parse(orderType: Int) {
        Parser.json(with: orderType) { (items) in
            self.movies = Movies(orderType: items.orderType, data: items.data)
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    private func configureTitle(from element: Int) {
        guard let sort = SortName(rawValue: element) else { return }
        self.navigationItem.title = sort.description
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc private func sorted() {
        let alert = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        let reservationRate = UIAlertAction(title: "예매율", style: .default) { (_) in
            self.configure(with: 0)
        }
        let curation = UIAlertAction(title: "큐레이션", style: .default) { (_) in
            self.configure(with: 1)
        }
        let date = UIAlertAction(title: "개봉일", style: .default) { (_) in
            self.configure(with: 2)
        }
        
        alert.addAction(reservationRate)
        alert.addAction(curation)
        alert.addAction(date)
        self.present(alert, animated: true, completion: nil)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        guard let items = movies?[indexPath.row] else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(from: items)
        return cell
    }
}

