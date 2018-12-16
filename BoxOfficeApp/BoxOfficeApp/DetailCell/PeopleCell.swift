//
//  PeopleCell.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorTitleLabel: UILabel!
    @IBOutlet weak var directorTextLabel: UILabel!
    @IBOutlet weak var actorTitleLabel: UILabel!
    @IBOutlet weak var actorTextLabel: UILabel!
    let terms = MovieTerms()
    
    func configure(from movie: Movie) {
        guard let director = movie.director else { return }
        guard let actor = movie.actor else { return }
        titleLabel.text = "\(terms.directorTitle) / \(terms.actorTitle)"
        directorTitleLabel.text = terms.directorTitle
        directorTextLabel.text = director
        actorTitleLabel.text = terms.actorTitle
        actorTextLabel.text = actor
    }

}
