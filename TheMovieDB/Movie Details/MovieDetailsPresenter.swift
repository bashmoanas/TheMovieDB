//
//  MovieDetailsPresenter.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 20/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

protocol MovieDetailsView: class {
    func updateUI(withMovieGenres movieGenres: [MoviesController.MovieGenre])
    func updateUI(withRelatedMovies movies: [MoviesController.Movie])
}

class MovieDetailsPresenter {
    weak var view: MovieDetailsView!
    let moviesController = MoviesController()
    
    init(view: MovieDetailsView) {
        self.view = view
    }
    func fetchMovieGenres() {
        APIClient.getGenres { (movieGenres) in
            self.view.updateUI(withMovieGenres: movieGenres)
        }
    }
    func fetchRelatedMovies(of movie: MoviesController.Movie) {
        APIClient.getRelatedMovies(of: movie) { (movies) in
            self.view.updateUI(withRelatedMovies: movies.results)
        }
    }
    
}
