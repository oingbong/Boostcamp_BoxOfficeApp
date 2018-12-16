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
    var cinema = Cinema.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        collectionview.dataSource = self
        collectionview.delegate = self
        appendButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let title = self.navigationItem.title ?? ""
        let selectedOrderType = OrderType.selected(with: title)
        // 타이틀값 없거나 모델이 가진 타입과 다르다면 변경 or 아니면 그대로 둡니다.
        if selectedOrderType < 0 || cinema.orderType() != selectedOrderType {
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
        let reservationRate = UIAlertAction(title: OrderType.rate.description, style: .default) { (_) in
            self.configure(with: 0)
        }
        let curation = UIAlertAction(title: OrderType.curation.description, style: .default) { (_) in
            self.configure(with: 1)
        }
        let date = UIAlertAction(title: OrderType.date.description, style: .default) { (_) in
            self.configure(with: 2)
        }
        
        alert.addAction(reservationRate)
        alert.addAction(curation)
        alert.addAction(date)
        self.present(alert, animated: true, completion: nil)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cinema.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        guard let items = cinema.movies?[indexPath.row] else { return UICollectionViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(from: items)
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.id = cinema.movies?[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)

    }
}

extension CollectionViewController {
    private func configureObservers() {
        let key = Notification.Name(rawValue: "updateItem")
        NotificationCenter.default.addObserver(self, selector: #selector(updateItems), name: key, object: nil)
    }
    
    @objc private func updateItems() {
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
}
