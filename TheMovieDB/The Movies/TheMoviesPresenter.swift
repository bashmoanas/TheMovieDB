//
//  TheMoviesPresenter.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 19/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

protocol TheMoviesView:class {
    func updateUI(withMovies movies: MoviesController.MovieCategory)
}

class TheMoviesPresenter {
    // MARK: - Properties
    weak var view: TheMoviesView?
    
    // MARK: - Initializers
    init(view: TheMoviesView) {
        self.view = view
    }
    
    // MARK: - Presenter Functions
    func fetchTopRatedMovies() {
        APIClient.getTopRatedMovies { (movies) in
            let newCategory = MoviesController.MovieCategory(name: "Top Rated Movies", movies: movies.results)
            self.view?.updateUI(withMovies: newCategory)
            self.fetchPopularMovies()
        }
    }
    private func fetchPopularMovies() {
        APIClient.getPopularMovies { (movies) in
            let newCategory = MoviesController.MovieCategory(name: "Popular Movies", movies: movies.results)
            self.view?.updateUI(withMovies: newCategory)
            self.fetchComingSoonMovies()
        }
    }
    func fetchComingSoonMovies() {
        APIClient.getComingSoonMovies { (movies) in
            let newCategory = MoviesController.MovieCategory(name: "Coming Soon Movies", movies: movies.results)
            self.view?.updateUI(withMovies: newCategory)
            self.fetchNowPlayingMovies()
        }
    }
    private func fetchNowPlayingMovies() {
        APIClient.getNowPlayingMovies { (movies) in
            let newCategory = MoviesController.MovieCategory(name: "Now Playing Movies", movies: movies.results)
            self.view?.updateUI(withMovies: newCategory)
        }
    }
}
