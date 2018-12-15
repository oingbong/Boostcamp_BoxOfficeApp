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
    // for infoStackView
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    // for subInfoStackView
    @IBOutlet weak var subInfoStackView: UIStackView!
    @IBOutlet weak var reservationInfoLabel: UILabel!
    @IBOutlet weak var reservationTextLabel: UILabel!
    @IBOutlet weak var userRatingInfoLabel: UILabel!
    @IBOutlet weak var userRatingTextLabel: UILabel!
    @IBOutlet weak var audienceInfoLabel: UILabel!
    @IBOutlet weak var audienceTextLabel: UILabel!
    
    func configure(from movie: Movie) {
        appendPropertyInfo(with: movie)
        appendPropertySubInfo(with: movie)
    }
    
    private func appendPropertyInfo(with movie: Movie) {
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
    
    private func appendPropertySubInfo(with movie: Movie) {
        reservationInfoLabel.text = "예매율"
        let grade = String(movie.reservation_grade)
        let rate = String(movie.reservation_rate)
        reservationTextLabel.text = "\(grade)위 \(rate)%"
        userRatingInfoLabel.text = "평점"
        userRatingTextLabel.text = String(movie.user_rating)
        audienceInfoLabel.text = "누적관객수"
        let audience = movie.audience ?? 0
        audienceTextLabel.text = String(audience)
    }
}
