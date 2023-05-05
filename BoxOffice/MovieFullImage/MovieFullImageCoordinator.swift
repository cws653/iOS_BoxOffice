//
//  MovieFullImageCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/05/01.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

protocol MovieFullImageFlow: AnyObject {
    func makeMoviewFullImageViewModel(with image: UIImage)
}

class MovieFullImageCoordinator: Coordinator, MovieFullImageFlow {
    var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private var movieFullImageViewModel: MovieFullImageViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieFullImageViewController = MovieFullImageViewController.instantiate()
        movieFullImageViewController.modalPresentationStyle = .fullScreen
        movieFullImageViewController.viewModel = self.movieFullImageViewModel
        navigationController.present(movieFullImageViewController, animated: false)
    }
    
    func makeMoviewFullImageViewModel(with image: UIImage) {
        self.movieFullImageViewModel = MovieFullImageViewModel(fullImage: image)
    }
    
}
