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
    @IBOutlet weak var starStackView: StarStackView!
    let terms = MovieTerms()
    
    func configure(from movie: Movie) {
        appendPropertyInfo(with: movie)
        appendPropertySubInfo(with: movie)
        appendTapGesture()
    }
    
    private func appendPropertyInfo(with movie: Movie) {
        titleLabel.text = movie.title
        posterImage.image = UIImage(named: terms.imagePlaceHolder)
        if let image = movie.image, let thumbUrl = URL(string: image), let thumbData = try? Data(contentsOf: thumbUrl) {
            self.posterImage.image = UIImage(data: thumbData)
        }
        gradeImage.image = UIImage(named: "\(terms.defaultName)\(movie.grade)") ?? UIImage(named: terms.defaultImage)
        dateLabel.text = "\(movie.date) \(terms.release)"
        guard let genre = movie.genre, let duration = movie.duration else { return }
        descLabel.text = "\(genre) / \(duration)\(terms.minute)"
    }
    
    private func appendPropertySubInfo(with movie: Movie) {
        reservationInfoLabel.text = terms.rateTitle
        let grade = String(movie.reservationGrade)
        let rate = String(movie.raservationRate)
        reservationTextLabel.text = "\(grade)\(terms.rank) \(rate)\(terms.percent)"
        userRatingInfoLabel.text = terms.ratingTitle
        userRatingTextLabel.text = String(movie.userRating)
        audienceInfoLabel.text = terms.audience
        let audience = format(with: movie.audience ?? 0) ?? "0"
        audienceTextLabel.text = audience
        let star = movie.userRating
        starStackView.configure(count: Int(star))
    }
    
    private func format(with audience: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let result = formatter.string(from: NSNumber(value: audience))
        return result
    }
}

extension InfoCell {
    private func appendTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        posterImage.isUserInteractionEnabled = true
        posterImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view as? UIImageView else { return }
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        // for dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tapGesture)
        superview?.addSubview(newImageView)
        NotificationCenter.default.post(name: NotificationKey.isHidden, object: nil, userInfo: [NotificationKey.userInfoIsHidden : true])
    }
    
    @objc func dismissFullscreenImage(_ gesture: UITapGestureRecognizer) {
        gesture.view?.removeFromSuperview()
        NotificationCenter.default.post(name: NotificationKey.isHidden, object: nil, userInfo: [NotificationKey.userInfoIsHidden : false])
    }
}
