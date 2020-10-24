//
//  OverviewCell.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 20/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
    
    @IBOutlet weak var overviewDetailsLabel: UILabel!
    
    static let reuseIdentifier = "OverviewCell"
    
    func configure(withMovie movie: MoviesController.Movie) {
        overviewDetailsLabel.text = movie.plotSynopsis
    }
    @IBAction
    func readMoreButtonTapped(_ sender: UIButton) {
        overviewDetailsLabel.numberOfLines = overviewDetailsLabel.numberOfLines == 0 ? 4 : 0        
    }
}
