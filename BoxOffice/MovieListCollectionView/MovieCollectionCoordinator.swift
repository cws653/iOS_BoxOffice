//
//  MovieCollectionCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/30.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

class MovieCollectionCoordinator: Coordinator, MovieListFlow {
    var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private var movieCollectionViewModel = MovieListCollectionViewModel()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieCollectionController = MovieListCollectionViewController.instantiate()
        movieCollectionController.coordinator = self
        movieCollectionController.viewModel = self.movieCollectionViewModel
        
        navigationController.pushViewController(movieCollectionController, animated: true)
    }
    
    func coordinateToDetail(indexPath: IndexPath) {
        guard let movie = movieCollectionViewModel.movieList?[indexPath.row] else { return }
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController)
        movieDetailCoordinator.makeMovieDetailViewModel(with: movie)
        movieDetailCoordinator.start()
    }
}
