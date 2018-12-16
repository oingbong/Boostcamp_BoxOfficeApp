//
//  SynopsisCell.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class SynopsisCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    let terms = MovieTerms()
    
    func configure(from movie: Movie) {
        titleLabel.text = terms.synopsis
        guard let synopsis = movie.synopsis else { return }
        contentLabel.text = synopsis
    }
}
