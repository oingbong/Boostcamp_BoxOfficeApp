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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(from movie: Movie) {
        guard let director = movie.director else { return }
        guard let actor = movie.actor else { return }
        titleLabel.text = "감독 / 출연"
        directorTitleLabel.text = "감독"
        directorTextLabel.text = director
        actorTitleLabel.text = "출연"
        actorTextLabel.text = actor
    }

}
