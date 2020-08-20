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
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let reuseIdentifier = "AllPostersCell"
    var currentMovie: MoviesController.Movie?
    var didTapPoster: ((MoviesController.Movie) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerPosterCell()
    }
        
    private func registerPosterCell() {
        let nib = UINib(nibName: "PosterCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PosterCell.reuseIdentifier)
    }
}

// MARK: - CollectionView Data Source Methods
extension AllPostersCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return TheMoviesViewController.moviesToDisplay[section].movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseIdentifier, for: indexPath) as? PosterCell else { fatalError() }
        cell.configure(withMovie: TheMoviesViewController.moviesToDisplay[indexPath.section].movies[indexPath.item])
        return cell
    }
}

// MARK: - CollectionView Delegate Methods
extension AllPostersCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMovie = TheMoviesViewController.moviesToDisplay[indexPath.section].movies[indexPath.row]
        didTapPoster?(currentMovie)
    }
}
