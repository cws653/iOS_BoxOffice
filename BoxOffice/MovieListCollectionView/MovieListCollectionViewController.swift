//
//  CollectionViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController

final class MovieListCollectionViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    var viewModel = MovieListCollectionViewModel()
    
    @IBOutlet private weak var movieListCollectionView: UICollectionView!
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
        
        configureView()
        configureBinding()
    }

    private func configureView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        self.movieListCollectionView?.collectionViewLayout = layout
    }
    
    private func configureBinding() {
        
        let viewDidDisAppear = rx.viewDidDisappear.map { _ in () }
        let viewDidAppear = rx.viewDidAppear.map { _ in () }
        
        viewDidDisAppear
            .withLatestFrom(viewModel.movieSortType)
            .subscribe(onNext: {
                self.sendMovieSorType(with: $0)
            })
        
        viewDidAppear
            .subscribe(onNext: {
                self.movieListCollectionView?.reloadData()
            })
        
        viewModel.movieList
            .observe(on: MainScheduler.instance)
            .bind(to: movieListCollectionView.rx.items(cellIdentifier: MovieListCollectionViewCell.reusableIdentifier, cellType: MovieListCollectionViewCell.self)) { index, item, cell in
                
                cell.configure(model: item)
            }
            .disposed(by: disposeBag)
        
        movieListCollectionView.rx.modelSelected(Movies.self)
            .subscribe(onNext: { movie in
                let movieDetailViewController = MovieDetailsViewController.instantiate()
                movieDetailViewController.viewModel = MovieDetailViewModel(movies: movie)
                self.navigationController?.pushViewController(movieDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        movieListCollectionView.rx.setDelegate(self)
                    .disposed(by: disposeBag)
        
        viewModel.movieSortType
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.navigationItem.title = $0.title
            })
    }
    
    private func sendMovieSorType(with movieSortType: MovieSortType) {
        if let navigationController = self.tabBarController?.viewControllers?[safe: 0] as? UINavigationController {
            if let movieListTableViewController = navigationController.viewControllers.first as? MovieListTableViewController {
                movieListTableViewController.viewModel.getMovieSortType(with: movieSortType)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let targetSizeX: CGFloat = (collectionView.frame.width - 30) / 2
        
        return CGSize(width: targetSizeX, height: 2 * targetSizeX)
    }
}


