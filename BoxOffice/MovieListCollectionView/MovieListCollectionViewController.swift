//
//  CollectionViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

final class MovieListCollectionViewController: UIViewController {

    private var viewModel = MovieListCollectionViewModel()
    var sortMode: MovieSortMode? {
        didSet {
            self.viewModel.getMoviewList(movieMode: self.sortMode ?? .reservationRate) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.navigationItem.title = self.sortMode?.title
                    self.movieListCollectionView?.reloadData()
                }
            }
        }
    }

    @IBOutlet private weak var movieListCollectionView: UICollectionView?
    @IBAction private func navigationItemAction(_ sender: UIBarButtonItem) {
        self.showAlertController(
            title: "정렬방식 선택",
            message: "영화를 어떤 순서로 정렬할까요?",
            sortActionHandler: { sortMode in
                self.sortMode = sortMode
            }
        )
    }

    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortMode = .reservationRate
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = self.sortMode?.title
        self.movieListCollectionView?.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let navigationController = self.tabBarController?.viewControllers?[safe: 0] as? UINavigationController {
            if let movieListTableViewController = navigationController.viewControllers.first as? MovieListTableViewController {
                movieListTableViewController.sortMode = self.sortMode
            }
        }
    }
    
    private func setupView() {

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        self.movieListCollectionView?.collectionViewLayout = layout
    }
}

// MARK: - UICollectionViewDelegate
extension MovieListCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailsViewController.instantiate()
        movieDetailViewController.movie = self.viewModel.movieList?[indexPath.row]
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}


// MARK: - UICollectionViewDataSource
extension MovieListCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as MovieListCollectionViewCell
        
        guard let movieList = self.viewModel.movieList else {
            return UICollectionViewCell()
        }
        let imageData = self.viewModel.imageData
        
        cell.setupUI(model: movieList[safe: indexPath.row] ?? nil, thumbnailData: imageData[safe: indexPath.row] ?? nil)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let targetSizeX: CGFloat = (collectionView.frame.width - 30) / 2

        return CGSize(width: targetSizeX, height: 2 * targetSizeX)
    }
}


