//
//  APIClient.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 19/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class APIClient {
    static func getTopRatedMovies(completion: @escaping (MoviesController.Movies) -> Void) {
        AF.request(APIRouter.topRatedMovies).validate().responseDecodable(of: MoviesController.Movies.self) { (response) in
            guard let movies = response.value else { return }
            completion(movies)
        }
    }
    static func getPopularMovies(completion: @escaping (MoviesController.Movies) -> Void) {
        AF.request(APIRouter.popularMovies).validate().responseDecodable(of: MoviesController.Movies.self) { (response) in
            guard let movies = response.value else { return }
            completion(movies)
        }
    }
    static func getComingSoonMovies(completion: @escaping (MoviesController.Movies) -> Void) {
        AF.request(APIRouter.comingSoon).validate().responseDecodable(of: MoviesController.Movies.self) { (response) in
            guard let movies = response.value else { return }
            completion(movies)
        }
    }
    static func getNowPlayingMovies(completion: @escaping (MoviesController.Movies) -> Void) {
        AF.request(APIRouter.nowPlaying).validate().responseDecodable(of: MoviesController.Movies.self) { (response) in
            guard let movies = response.value else { return }
            completion(movies)
        }
    }
    static func getGenres(completion: @escaping ([MoviesController.MovieGenre]) -> Void) {
        AF.request(APIRouter.moviesGenres).validate().responseDecodable(of: MoviesController.MoviesGenres.self) { (response) in
            guard let result = response.value else { return }
            completion(result.genres)
        }
    }
    static func getRelatedMovies(of movie: MoviesController.Movie, completion: @escaping (MoviesController.Movies) -> Void) {
        let url = "\(Constants.baseURL)/movie/\(movie.id)/similar?api_key=\(Constants.apiKey)"
        guard let path = URL(string: url) else { return }
        AF.request(path).validate().responseDecodable(of: MoviesController.Movies.self) { (response) in
            guard let result = response.value else { return }
            completion(result)
        }
    }
}
