//
//  MovieDetailCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/05/01.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

protocol MovieDetailFlow {
    func coordinateToMakeComment()
    func coordinateToFullImage(image: UIImage)
    func makeMovieDetailViewModel(with movie: Movies)
}

class MovieDetailCoordinator: Coordinator, MovieDetailFlow {

    var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private var movieDetailViewModel: MovieDetailViewModel?
    weak var makeCommentDelegate: MakeCommentsViewDelegate?
    var movieDetailViewController: MovieDetailsViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieDetailViewController = MovieDetailsViewController.instantiate()
        self.movieDetailViewController = movieDetailViewController
        movieDetailViewController.coordinator = self
        movieDetailViewController.viewModel = self.movieDetailViewModel
        makeCommentDelegate = movieDetailViewController
        
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
    
    func coordinateToMakeComment() {
        guard let movie = movieDetailViewModel?.movie else { return }
        let makeCommentCoordinator = MakeCommentCoordinator(navigationController: navigationController)
        makeCommentCoordinator.makeCommentViewDelegate = self.makeCommentDelegate
        makeCommentCoordinator.makeCommentViewModel(with: movie)
        makeCommentCoordinator.start()
    }
    
    func coordinateToFullImage(image: UIImage) {
        let movieFullImageCoordinator = MovieFullImageCoordinator(navigationController: navigationController)
        movieFullImageCoordinator.makeMoviewFullImageViewModel(with: image)
        movieFullImageCoordinator.start()
    }
    
    func makeMovieDetailViewModel(with movie: Movies) {
        self.movieDetailViewModel = MovieDetailViewModel(movie: movie)
    }
}
