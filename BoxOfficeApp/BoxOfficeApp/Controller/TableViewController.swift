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
    
    /*
     정렬기준 데이터 공유에 대한 설명
     1. 둘다 nil : 처음에만 발생하는 상황이므로 viewDidLoad 에서 디폴트값 0 으로 처리
     2. 둘다 있거나
     1) 동일하면 데이터 유지 : nothing
     2) 다르면 컬렉션뷰 따라가기 : 세팅 및 데이터 호출
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        appendButtonItem()
        configure(with: 0) // 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let tabBar = self.tabBarController?.viewControllers else { return }
        guard let naviBar = tabBar[1] as? UINavigationController else { return }
        guard let collectionView = naviBar.viewControllers.first as? CollectionViewController else { return }
        // 2
        if let orderType = self.movies?.orderType,
            let anotherOrderType = collectionView.movies?.orderType,
            orderType != anotherOrderType {
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
        Parser.jsonUrl(with: String(orderType), type: .orderType) { (items) in
            guard let movieItem: Movies = Parser.decode(from: items) else { return }
            self.movies = movieItem
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

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.id = self.movies?[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
