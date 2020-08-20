//
//  PosterCell.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 20/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    
    static let reuseIdentifier = "PosterCell"
    
    func configure(withMovie movie: MoviesController.Movie) {
        APIClient.getPoster(forMovie: movie, withSize: Constants.posterSize) { (image) in
            self.posterImageView.image = image
        }
    }
}
