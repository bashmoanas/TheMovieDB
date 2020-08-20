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
    static func getPoster(forMovie movie: MoviesController.Movie, withSize size: String, completion: @escaping (UIImage) -> Void) {
        guard let url = try? "\(Constants.basePhotoURLString)\(size)\(movie.posterPath)".asURL() else { return }
        KingfisherManager.shared.retrieveImage(with: url) { (result) in
            switch result {
            case let .success(imageResult): completion(imageResult.image)
            case .failure(_): print("Error getting image by KingFisher")
            }
        }
    }
}
