//
//  PosterCell.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 20/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit
import Kingfisher

class PosterCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    static let reuseIdentifier = "PosterCell"
    
    func configure(withMovie movie: MoviesController.Movie) {
        
        posterImageView.kf.indicatorType = .activity
        
        let imageURL = "\(Constants.basePhotoURLString)\(Constants.posterSize)\(movie.posterPath)"
        guard let path = URL(string: imageURL) else { return }
        posterImageView.kf.setImage(with: ImageResource(downloadURL: path))
    }
}
