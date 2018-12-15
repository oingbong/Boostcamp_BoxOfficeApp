//
//  InfoCell.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var subInfoStackView: UIStackView!
    
    func configure(from movie: Movie) {
        titleLabel.text = movie.title
        posterImage.image = UIImage(named: "img_placeholder")
        if let image = movie.image, let thumbUrl = URL(string: image), let thumbData = try? Data(contentsOf: thumbUrl) {
            self.posterImage.image = UIImage(data: thumbData)
        }
        gradeImage.image = UIImage(named: "ic_\(movie.grade)") ?? UIImage(named: "ic_allages")
        dateLabel.text = "\(movie.date) 개봉"
        guard let genre = movie.genre, let duration = movie.duration else { return }
        descLabel.text = "\(genre) / \(duration)분"
    }
}
