//
//  CollectionViewCell.swift
//  BoxOfficeApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ageImage: UIImageView!
    
    func configure(from movie: Movie) {
        self.titleLabel.text = movie.title
        let rating = "평점 : " + String(movie.user_rating)
        let grade = "예매순위 : " + String(movie.reservation_grade)
        let rate = "예매율 : " + String(movie.reservation_rate)
        self.infoLabel.text = rating + grade + rate
        self.dateLabel.text = movie.date
        // thumb - 변경필요
        self.posterImage.image = UIImage(named: "img_placeholder")
        if let thumb = movie.thumb, let thumbUrl = URL(string: thumb), let thumbData = try? Data(contentsOf: thumbUrl) {
            self.posterImage.image = UIImage(data: thumbData)
        }
        // grade
        self.ageImage.image = UIImage(named: "ic_\(movie.grade)") ?? UIImage(named: "ic_allages")
    }
}
