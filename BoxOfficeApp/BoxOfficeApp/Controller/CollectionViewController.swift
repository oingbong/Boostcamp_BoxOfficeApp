//
//  CollectionViewController.swift
//  BoxOfficeApp
//
//  Created by oingbong on 05/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var collectionview: UICollectionView!
    private var cinema = Cinema.shared
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        appendButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let title = self.navigationItem.title ?? ""
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
        self.displaySpinner(view: self.view)
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

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cinema.moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        guard let items = cinema[indexPath.row] else { return UICollectionViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(from: items)
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.id = cinema[indexPath.row]?.id
        self.navigationController?.pushViewController(detailVC, animated: true)

    }
}

extension CollectionViewController {
    private func configureObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateItems), name: NotificationKey.updateItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sorted(_:)), name: NotificationKey.sorted, object: nil)
    }
    
    @objc private func updateItems() {
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    @objc private func sorted(_ notification: Notification) {
        guard let value = notification.userInfo?[NotificationKey.userInfoValue] as? Int else { return }
        configure(with: value)
    }
}

extension CollectionViewController {
    @objc private func refreshData(_ sender: Any) {
        let title = self.navigationItem.title ?? OrderType.rate.description
        let selectedOrderType = OrderType.selected(with: title)
        cinema.parse(with: selectedOrderType, viewController: self)
        refreshControl.endRefreshing()
    }
}
