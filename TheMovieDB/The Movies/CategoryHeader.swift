//
//  CategoryHeader.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 19/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class CategoryHeader: UITableViewHeaderFooterView {
    // MARK: - Outlets
    @IBOutlet weak var categoryHeaderLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    
    static let reuseIdentifier = "CategoryHeader"
    var currentSection: Int?
    var didTapSection: ((Int) -> Void)?
    
    // MARK: - Helper Methods
    func configure(withMovieCategory movieCategory: MoviesController.MovieCategory) {
        setupTapGesture()
        categoryHeaderLabel.text = movieCategory.name
        chevronImageView.image = movieCategory.isExpanded ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.right")
    }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSectionExpansion))
        contentView.addGestureRecognizer(tapGesture)
    }
    @objc
    func toggleSectionExpansion() {
        guard let currentSection = currentSection else { return }
        didTapSection?(currentSection)
    }
}
