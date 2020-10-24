//
//  RelatedMoviesCell.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 22/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class RelatedMoviesCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let reuseIdentifier = "RelatedMoviesCell"
    let moviesController = MoviesController()
    
    func configure(withMovie movie: MoviesController.Movie) {
        posterImageView.kf.indicatorType = .activity
        
        movieTitleLabel.text = movie.originalTitle
        descriptionLabel.text = "\(movie.userRating)"
        
        let imageURL = "\(Constants.basePhotoURLString)\(Constants.posterSize)\(movie.posterPath)"
        guard let path = URL(string: imageURL) else { return }
        posterImageView.kf.setImage(with: path)
    }
}
