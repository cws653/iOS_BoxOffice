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

final class MovieListTableViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var viewModel = MovieListTableViewModel()
    
//    var sortMode: MovieSortMode? {
//        didSet {
//            self.viewModel.getMoviewList(movieMode: self.sortMode ?? .reservationRate) { [weak self] in
//                guard let self = self else { return }
//                self.navigationItem.title = self.sortMode?.title
//                self.movieListTableView?.reloadData()
//            }
//        }
//    }

    @IBOutlet private weak var movieListTableView: UITableView!
    @IBAction private func navigationItemAction(_ sender: UIBarButtonItem) {
        self.showAlertController(
            title: "정렬방식 선택",
            message: "영화를 어떤 순서로 정렬할까요?",
            sortActionHandler: { sortMode in
//                self.sortMode = sortMode
            }
        )
    }
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.sortMode = .reservationRate
        configureBinding()
    }
    
    func configureBinding() {
        
//        Observable.zip(viewModel.movieList, viewModel.imageData)
//            .subscribe(onNext: {
//                print($0.0, $0.1)
//            })
        
//        let movieData = Observable
//            .zip(viewModel.movieList.asObservable(), viewModel.imageData.asObservable())
//            .bind(to: movieListTableView.rx.items(cellIdentifier: MovieListTableViewCell.reusableIdentifier, cellType: MovieListTableViewCell.self)) { (index: Int, item: ([Movies], [Data]), cell: MovieListTableViewCell) in
//                
//                cell.configure(model: item.0[index], thumbnailData: item.1[index])
//            }
//            .disposed(by: disposeBag)
        
        viewModel.movieList
            .observeOn(MainScheduler.instance)
            .bind(to: movieListTableView.rx.items(cellIdentifier: MovieListTableViewCell.reusableIdentifier, cellType: MovieListTableViewCell.self)) { index, item, cell in
                
                cell.configure(model: item, thumbnailData: item.imageData)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.navigationItem.title = self.sortMode?.title
        self.movieListTableView?.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = self.tabBarController?.viewControllers?[safe: 1] as? UINavigationController {
            if let movieListCollectionViewController = navigationController.viewControllers.first as? MovieListCollectionViewController {
//                movieListCollectionViewController.sortMode = self.sortMode
            }
        }
    }
}

// MARK: - UITableViewDelegeate
//extension MovieListTableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movieDetailViewController = MovieDetailsViewController.instantiate()
//        movieDetailViewController.initMovies(with: self.viewModel.movieList?[indexPath.row])
//        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
//    }
//}

// MARK: - UITableViewDataSource
//extension MovieListTableViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.movieList?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieListTableViewCell
//        guard let movieList = self.viewModel.movieList else {
//            return UITableViewCell()
//        }
//        let imageData = self.viewModel.imageData
//
//        cell.configure(model: movieList[safe: indexPath.row], thumbnailData: imageData[safe: indexPath.row])
//
//        return cell
//    }
//}





