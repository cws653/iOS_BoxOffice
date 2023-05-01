//
//  ViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

final class MovieListTableViewController: UIViewController, StoryboardBased {
    static var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
    
    var coordinator: MovieTableCoordinator?
    var viewModel: MovieListTableViewModel?
    var sortMode: MovieSortMode? {
        didSet {
            self.viewModel?.getMoviewList(movieMode: self.sortMode ?? .reservationRate) { [weak self] in
                guard let self = self else { return }
                self.navigationItem.title = self.sortMode?.title
                self.movieListTableView?.reloadData()
            }
        }
    }
    
    @IBOutlet private weak var movieListTableView: UITableView?
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = self.sortMode?.title
        self.movieListTableView?.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = self.tabBarController?.viewControllers?[safe: 1] as? UINavigationController {
            if let movieListCollectionViewController = navigationController.viewControllers.first as? MovieListCollectionViewController {
                movieListCollectionViewController.sortMode = self.sortMode
            }
        }
    }
}

// MARK: - UITableViewDelegeate
extension MovieListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.coordinateToDetail(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension MovieListTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.movieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieListTableViewCell
        guard let movieList = self.viewModel?.movieList else {
            return UITableViewCell()
        }
        let imageData = self.viewModel?.imageData
        
        cell.configure(model: movieList[safe: indexPath.row], thumbnailData: imageData?[safe: indexPath.row])
        
        return cell
    }
}





