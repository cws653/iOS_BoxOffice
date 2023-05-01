//
//  TableViewCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/30.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

class MovieTableCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private var movieListTableViewModel: MovieListTableViewModel = MovieListTableViewModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieTableViewController = MovieListTableViewController.instantiate()
        movieTableViewController.coordinator = self
        movieTableViewController.viewModel = self.movieListTableViewModel
        
        navigationController.pushViewController(movieTableViewController, animated: false)
    }
    
    func coordinateToDetail(indexPath: IndexPath) {
        guard let movie = movieListTableViewModel.movieList?[indexPath.row] else { return }
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController)
        movieDetailCoordinator.makeMovieDetailViewModel(movie: movie)
        movieDetailCoordinator.start()
    }
}
