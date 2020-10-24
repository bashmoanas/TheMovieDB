//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 20/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerPosterImageView: UIImageView!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var headerGenresLabel: UILabel!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    let moviesController = MoviesController()
    var movieDetailsPresenter: MovieDetailsPresenter?
    var movie: MoviesController.Movie?
    var image: UIImage?
    var formattedDate: String?
    var relatedMovies = [MoviesController.Movie]() { didSet { tableView.reloadData() } }
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsPresenter = MovieDetailsPresenter(view: self)
        movieDetailsPresenter?.fetchMovieGenres()
        navigationController?.setNavigationBarHidden(true, animated: true)
        registerOverviewCell()
        registerRelatedMoviesCell()
        guard let movie = movie else { return }
        movieDetailsPresenter?.fetchRelatedMovies(of: movie)
        updateHeader(withMovie: movie)
        configureButtonTitlesUnderImages()
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension MovieDetailsViewController {
    private func registerOverviewCell() {
        let nib = UINib(nibName: "OverviewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: OverviewCell.reuseIdentifier)
    }
    private func registerRelatedMoviesCell() {
        let nib = UINib(nibName: "RelatedMoviesCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RelatedMoviesCell.reuseIdentifier)
    }
    private func updateHeader(withMovie movie: MoviesController.Movie) {
        headerPosterImageView.image = image
        headerTitleLabel.text = movie.originalTitle
        headerGenresLabel.text = ""
        reviewsLabel.text = "\(movie.userRating) (\(movie.voteCount)) Reviews"
        durationLabel.text = movie.duration != nil ? "\(movie.duration!)" : "N/A"
        releaseDateLabel.text = decodeReleaseDate()
        setupPosterImage()
        setupBackdropImage()
    }
    private func decodeReleaseDate() -> String? {
        let dateFormatterReceived = DateFormatter()
        dateFormatterReceived.dateFormat = "yyyy-MM-dd"
        let dateFormatterToDisplay = DateFormatter()
        dateFormatterToDisplay.dateFormat = "MMM dd, yyyy"
        guard let date = dateFormatterReceived.date(from: movie!.releaseDate) else { return nil }
        formattedDate = dateFormatterToDisplay.string(from: date)
        return "\(formattedDate!) Released"
    }
    private func configureButtonTitlesUnderImages() {
        bookmarkButton.alignTextBelow()
        favoriteButton.alignTextBelow()
        shareButton.alignTextBelow()
    }
    private func setupPosterImage() {
        headerPosterImageView.kf.indicatorType = .activity
        guard let posterPath = movie?.posterPath else { return }
        let imageURL = "\(Constants.basePhotoURLString)\(Constants.posterSize)\(posterPath)"
        guard let path = URL(string: imageURL) else { return }
        headerPosterImageView.kf.setImage(with: path)
    }
    private func setupBackdropImage() {
        backDropImageView.kf.indicatorType = .activity
        guard let backdropPath = movie?.backdropPath else { return }
        let imageURL = "\(Constants.basePhotoURLString)\(Constants.posterSize)\(backdropPath)"
        guard let path = URL(string: imageURL) else { return }
        backDropImageView.kf.setImage(with: path)
    }
}

//MARK: - ACTIONS

extension MovieDetailsViewController {
    @IBAction
    func navigatToHome(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableView Data Source Methods
extension MovieDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return relatedMovies.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewCell.reuseIdentifier) as? OverviewCell else { fatalError() }
            guard let movie = movie else { fatalError() }
            cell.configure(withMovie: movie)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RelatedMoviesCell.reuseIdentifier) as? RelatedMoviesCell else { fatalError() }
            let movie = relatedMovies[indexPath.row]
            cell.configure(withMovie: movie)
            return cell
        }
        
    }
}

// MARK: - UITableView Delegate Methods
extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Overview"
        default:
            return "Related Movies"
        }
    }
}

// MARK: - MovieDetailsView Delegate Methods
extension MovieDetailsViewController: MovieDetailsView {
    func updateUI(withMovieGenres movieGenres: [MoviesController.MovieGenre]) {
        moviesController.allMoviesGenres.append(contentsOf: movieGenres)
        guard let movie = movie else { return }
        let currentMovieGenre = moviesController.displayfilteredGenres(movie.genreIDs, in: moviesController.allMoviesGenres)
        headerGenresLabel.text = currentMovieGenre
    }
    func updateUI(withRelatedMovies movies: [MoviesController.Movie]) {
        relatedMovies = movies
    }
}
