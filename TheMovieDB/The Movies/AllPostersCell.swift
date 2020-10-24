//
//  PosterCell.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 19/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit
import Kingfisher

class AllPostersCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.registerPosterCell()
        }
    }
    
    var movies = [MoviesController.Movie]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    static let reuseIdentifier = "AllPostersCell"
    var didTapPoster: ((Int, Int) -> Void)?
    var tappedSection: Int!
    
    private func registerPosterCell() {
        let nib = UINib(nibName: "PosterCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PosterCell.reuseIdentifier)
    }
    
    func configure(withMovies movies: [MoviesController.Movie], atSection section: Int) {
        self.movies = movies
        tappedSection = section
    }
}

// MARK: - CollectionView Data Source Methods
extension AllPostersCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseIdentifier, for: indexPath) as! PosterCell
        cell.configure(withMovie: movies[indexPath.item])
        
        return cell
    }
}

// MARK: - CollectionView Delegate Methods
extension AllPostersCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapPoster?(tappedSection, indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseIdentifier, for: indexPath) as! PosterCell
        cell.posterImageView.layer.cornerRadius = 50
        cell.posterImageView.layer.masksToBounds = true
        cell.posterImageView.clipsToBounds = true
    }
}
