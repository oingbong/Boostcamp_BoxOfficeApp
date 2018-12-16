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
    let terms = MovieTerms()
    
    func configure(from movie: Movie) {
        self.titleLabel.text = movie.title
        self.titleLabel.adjustsFontSizeToFitWidth = true
        let rating = String(movie.user_rating)
        let grade = String(movie.reservation_grade)
        let rate = String(movie.reservation_rate)
        self.infoLabel.text = "\(grade)\(terms.rank)(\(rating) / \(rate)\(terms.percent))"
        self.dateLabel.text = movie.date
        // thumb - 변경필요
        self.posterImage.image = UIImage(named: terms.imagePlaceHolder)
        if let thumb = movie.thumb, let thumbUrl = URL(string: thumb), let thumbData = try? Data(contentsOf: thumbUrl) {
            self.posterImage.image = UIImage(data: thumbData)
        }
        // grade
        self.ageImage.image = UIImage(named: "\(terms.defaultName)\(movie.grade)") ?? UIImage(named: terms.defaultImage)
    }
}
