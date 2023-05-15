//
//  ViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController

final class MovieListTableViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    var viewModel = MovieListTableViewModel()

    @IBOutlet private weak var movieListTableView: UITableView!
    @IBAction private func navigationItemAction(_ sender: UIBarButtonItem) {
        self.showAlertController(
            title: "정렬방식 선택",
            message: "영화를 어떤 순서로 정렬할까요?",
            sortActionHandler: { sortMode in
                self.viewModel.getMovieSortType(with: sortMode)
            }
        )
    }
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBinding()
    }
    
    func configureBinding() {
        
        let viewDidDisAppear = rx.viewDidDisappear.map { _ in () }
        let viewDidAppear = rx.viewDidAppear.map { _ in () }
        
        viewDidDisAppear
            .withLatestFrom(viewModel.movieSortType)
            .subscribe(onNext: {
                self.sendMovieSorType(with: $0)
            })
        
        viewDidAppear
            .subscribe(onNext: {
                self.movieListTableView?.reloadData()
            })
    
        viewModel.movieList
            .observe(on: MainScheduler.instance)
            .bind(to: movieListTableView.rx.items(cellIdentifier: MovieListTableViewCell.reusableIdentifier, cellType: MovieListTableViewCell.self)) { index, item, cell in
                
                cell.configure(model: item)
            }
            .disposed(by: disposeBag)
        
        movieListTableView.rx.modelSelected(Movies.self)
            .subscribe(onNext: { movie in
                let movieDetailViewController = MovieDetailsViewController.instantiate()
                movieDetailViewController.viewModel = MovieDetailViewModel(movies: movie)
                self.navigationController?.pushViewController(movieDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.movieSortType
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.navigationItem.title = $0.title
            })
            .disposed(by: disposeBag)
    }
    
    private func sendMovieSorType(with movieSortType: MovieSortType) {
        if let navigationController = self.tabBarController?.viewControllers?[safe: 1] as? UINavigationController {
            if let movieListCollectionViewController = navigationController.viewControllers.first as? MovieListCollectionViewController {
                movieListCollectionViewController.viewModel.getMovieSortType(with: movieSortType)
            }
        }
    }
}
