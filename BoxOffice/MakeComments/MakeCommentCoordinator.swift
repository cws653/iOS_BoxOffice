//
//  MakeCommentCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/05/01.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

class MakeCommentCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private var makeCommentViewModel: MakeCommentViewModel?
    
    init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parent
    }
    
    func start() {
        let makeCommentViewController = MakeCommentsViewController.instantiate()
        makeCommentViewController.viewModel = self.makeCommentViewModel
        navigationController.pushViewController(makeCommentViewController, animated: false)
    }
    
    func makeCommentViewModel(movie: Movies) {
        self.makeCommentViewModel = MakeCommentViewModel(movie: movie)
    }
}
