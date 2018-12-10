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
    var movies: Movies?
    
    /*
     정렬기준 데이터 공유에 대한 설명
     1. 컬렉션뷰의 orderType nil : 테이블뷰 따라가기
     2. 둘다 있거나
     1) 동일하면 데이터 유지 : nothing
     2) 다르면 테이블뷰 따라가기 : 세팅 및 데이터 호출
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource = self
        appendButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let tabBar = self.tabBarController?.viewControllers else { return }
        guard let naviBar = tabBar[0] as? UINavigationController else { return }
        guard let tableView = naviBar.viewControllers.first as? TableViewController else { return }
        
        if let orderType = self.movies?.orderType,
            let anotherOrderType = tableView.movies?.orderType,
            orderType != anotherOrderType {
            // 2
            self.movies?.orderType = anotherOrderType
            configure(with: anotherOrderType)
        } else if let anotherOrderType = tableView.movies?.orderType {
            // 1
            self.movies?.orderType = anotherOrderType
            configure(with: anotherOrderType)
        }
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
                self.collectionview.reloadData()
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

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        guard let items = movies?[indexPath.row] else { return UICollectionViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(from: items)
        return cell
    }
}
