//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 20/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: MoviesController.Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movie?.originalTitle)
    }
}
