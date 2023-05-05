//
//  MakeCommentCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/05/01.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

protocol makeCommentFlow: AnyObject {
    func makeCommentViewModel(with movie: Movies)
}

class MakeCommentCoordinator: Coordinator, makeCommentFlow {
    var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private var makeCommentViewModel: MakeCommentViewModel?
    weak var makeCommentViewDelegate: MakeCommentsViewDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let makeCommentViewController = MakeCommentsViewController.instantiate()
        makeCommentViewController.viewModel = self.makeCommentViewModel
        makeCommentViewController.delegate = self.makeCommentViewDelegate
        navigationController.pushViewController(makeCommentViewController, animated: false)
    }
    
    func makeCommentViewModel(with movie: Movies) {
        self.makeCommentViewModel = MakeCommentViewModel(movie: movie)
    }
}
