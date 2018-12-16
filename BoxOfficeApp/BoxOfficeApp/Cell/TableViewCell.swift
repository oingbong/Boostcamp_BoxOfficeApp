//
//  TableViewCell.swift
//  BoxOfficeApp
//
//  Created by oingbong on 05/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ageImage: UIImageView!
    let terms = MovieTerms()
    
    func configure(from movie: Movie) {
        self.titleLabel.text = movie.title
        let rating = "\(terms.ratingTitle) : \(String(movie.userRating))"
        let grade = "\(terms.gradeTitle) : \(String(movie.reservationGrade))"
        let rate = "\(terms.rateTitle) : \(String(movie.raservationRate))"
        self.infoLabel.text = "\(rating) \(grade) \(rate)"
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
