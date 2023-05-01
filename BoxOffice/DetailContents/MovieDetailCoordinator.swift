//
//  MovieDetailCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/05/01.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

class MovieDetailCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private var movieDetailViewModel: MovieDetailViewModel?
    var movieDetailViewController: MovieDetailsViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieDetailViewController = MovieDetailsViewController.instantiate()
        self.movieDetailViewController = movieDetailViewController
        movieDetailViewController.coordinator = self
        movieDetailViewController.viewModel = self.movieDetailViewModel
        
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
    
    func coordinateToMakeComment() {
        guard let movie = movieDetailViewModel?.movie else { return }
        let makeCommentViewController = MakeCommentsViewController.instantiate()
        makeCommentViewController.delegate = movieDetailViewController
        makeCommentViewController.viewModel = MakeCommentViewModel(movie: movie)
        navigationController.pushViewController(makeCommentViewController, animated: false)
    }
    
    func coordinateToFullImage(image: UIImage) {
        let movieFullImageCoordinator = MovieFullImageCoordinator(navigationController: navigationController)
        movieFullImageCoordinator.makeMovieFullImageViewModel(image: image)
        movieFullImageCoordinator.start()
    }
    
    func makeMovieDetailViewModel(movie: Movies) {
        self.movieDetailViewModel = MovieDetailViewModel(movie: movie)
    }
}
