//
//  CommentCell.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var starStackView: StarStackView!
    
    func configure(from movieEvaluation: MovieEvaluation) {
        writerLabel.text = movieEvaluation.writer
        timeStampLabel.text = format(with: movieEvaluation.timestamp)
        contentsLabel.text = movieEvaluation.contents
        let star = movieEvaluation.rating
        starStackView.configure(count: Int(star))
    }
    
    private func format(with timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = dateFormatter.string(from: date)
        return result
    }
}
