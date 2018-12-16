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
    var cinema = Cinema.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        tableview.dataSource = self
        tableview.delegate = self
        appendButtonItem()
        configure(with: 0) // 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let title = self.navigationItem.title else { return }
        let selectedOrderType = OrderType.selected(with: title)
        if cinema.orderType() != selectedOrderType {
            configure(with: cinema.orderType())
        }
    }
    
    private func appendButtonItem() {
        guard let image = UIImage(named: "ic_settings") else { return }
        let buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(sorted))
        buttonItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    private func configure(with element: Int) {
        cinema.parse(with: element)
        configureTitle(from: element)
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
        return cinema.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        guard let items = cinema.movies?[indexPath.row] else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(from: items)
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.id = cinema.movies?[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TableViewController {
    private func configureObservers() {
        let key = Notification.Name(rawValue: "updateItem")
        NotificationCenter.default.addObserver(self, selector: #selector(updateItems), name: key, object: nil)
    }
    
    @objc private func updateItems() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}
