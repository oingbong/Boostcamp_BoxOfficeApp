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
    private var cinema = Cinema.shared
    
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
        let buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(sortedAlert))
        buttonItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    private func configure(with element: Int) {
        cinema.parse(with: element, viewController: self)
        configureTitle(from: element)
    }
    
    private func configureTitle(from element: Int) {
        guard let sort = SortName(rawValue: element) else { return }
        self.navigationItem.title = sort.description
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc private func sortedAlert() {
        let alert = UIAlertController.sorted()
        self.present(alert, animated: true, completion: nil)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinema.moviesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        guard let items = cinema[indexPath.row] else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(from: items)
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.id = cinema[indexPath.row]?.id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TableViewController {
    private func configureObservers() {
        let updateItemKey = Notification.Name(rawValue: "updateItem")
        NotificationCenter.default.addObserver(self, selector: #selector(updateItems), name: updateItemKey, object: nil)
        let sortedKey = Notification.Name(rawValue: "sorted")
        NotificationCenter.default.addObserver(self, selector: #selector(sorted(_:)), name: sortedKey, object: nil)
    }
    
    @objc private func updateItems() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    @objc private func sorted(_ notification: Notification) {
        guard let value = notification.userInfo?["value"] as? Int else { return }
        configure(with: value)
    }
}
