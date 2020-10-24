//
//  Movie.swift
//  TheMovieApp
//
//  Created by Anas Bashandy on 16/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

class MoviesController {
    struct MovieCategory {
        var name: String
        var movies: [Movie]
        var isExpanded = true
    }
    
    struct MovieGenre: Codable {
        let id: Int
        let name: String
    }
    struct MoviesGenres: Codable {
        let genres: [MovieGenre]
    }
    
    struct Movies: Codable {
        let results: [Movie]
    }
    struct Movie: Codable {
        let posterPath: String
        let id: Int
        let originalTitle: String
        let plotSynopsis: String?
        let userRating: Double
        let releaseDate: String
        let voteCount: Int
        let duration: Int?
        let genreIDs: [Int]
        let backdropPath: String?
        
        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
            case id
            case originalTitle = "original_title"
            case plotSynopsis = "overview"
            case userRating = "vote_average"
            case releaseDate = "release_date"
            case voteCount = "vote_count"
            case duration = "runtime"
            case genreIDs = "genre_ids"
            case backdropPath = "backdrop_path"
        }
    }
    var allMoviesGenres = [MoviesController.MovieGenre]()
    func displayfilteredGenres(_ genresIDs: [Int], in allGenres: [MoviesController.MovieGenre]) -> String {
        var currentMovieGenres = [MoviesController.MovieGenre]()
        for id in allGenres {
            if genresIDs.contains(id.id) {
                currentMovieGenres.append(id)
            }
        }
        let genreAsText = currentMovieGenres.map { $0.name }
        return genreAsText.joined(separator: ", ")
    }
}
