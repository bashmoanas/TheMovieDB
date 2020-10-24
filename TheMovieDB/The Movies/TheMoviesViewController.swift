//
//  TheMoviesViewController.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 19/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class TheMoviesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var theMoviesPresenter: TheMoviesPresenter?
    var moviesToDisplay = [MoviesController.MovieCategory]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        theMoviesPresenter = TheMoviesPresenter(view: self)
        registerCategoryHeader()
        adjustSectionHeight()
        registerAllPostersCell()
        theMoviesPresenter?.fetchTopRatedMovies()
    }
}

// MARK: - Helper Methods
extension TheMoviesViewController {
    func registerCategoryHeader() {
        let nib = UINib(nibName: "CategoryHeader", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: CategoryHeader.reuseIdentifier)
    }
    func registerAllPostersCell() {
        let nib = UINib(nibName: "AllPostersCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AllPostersCell.reuseIdentifier)
    }
    func adjustSectionHeight() {
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44.0
    }
}

// MARK: - tableView Data Source Methods
extension TheMoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesToDisplay.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllPostersCell.reuseIdentifier, for: indexPath) as? AllPostersCell else { fatalError() }
        cell.configure(withMovies: moviesToDisplay[indexPath.section].movies, atSection: indexPath.section)
        
//        TheMoviesViewController.sectionInCollectionView = indexPath.section
        cell.didTapPoster = { (section, item) in
            let movieDetailsViewController = MovieDetailsViewController.instantiateViewController(fromStoryboard: .main)
            movieDetailsViewController.movie = self.moviesToDisplay[section].movies[item]
            self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
        }
        return cell
    }
}

// MARK: - tableView Delegate Methods
extension TheMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let categoryHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryHeader.reuseIdentifier) as? CategoryHeader else { fatalError() }
        categoryHeader.currentSection = section
        categoryHeader.didTapSection = { (currentSection) in
            self.moviesToDisplay[section].isExpanded.toggle()
            tableView.reloadData()
        }
         categoryHeader.configure(withMovieCategory: moviesToDisplay[section])
        return categoryHeader
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return moviesToDisplay[indexPath.section].isExpanded ? 200 : 0
    }
    
}

// MARK: - TheMovieView Delegate Methods
extension TheMoviesViewController: TheMoviesView {
    func updateUI(withMovies movies: MoviesController.MovieCategory) {
        moviesToDisplay.append(movies)
        tableView.reloadData()
    }
}
