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
        timeStampLabel.text = String(movieEvaluation.timestamp)
        contentsLabel.text = movieEvaluation.contents
        let star = movieEvaluation.rating
        starStackView.configure(count: Int(star))
    }
}
