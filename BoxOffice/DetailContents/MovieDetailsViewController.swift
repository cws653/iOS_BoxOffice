//
//  SecondTableViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController

final class MovieDetailsViewController: UIViewController, StoryboardBased, DetailMakeCommentCellDelegate, DetailPosterCellDelegate {
    
    static var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
    
    var disposeBag = DisposeBag()
    var viewModel: MovieDetailViewModel?
    
    @IBOutlet private weak var movieDetailTableView: UITableView!
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureBinding()
    }
    
    private func configureView() {
//        self.movieDetailTableView?.delegate = self
//        self.movieDetailTableView?.dataSource = self
        self.viewModel?.tableViewSectionCount = 5
        
//        guard let movie = self.viewModel?.movies else { return }
//        self.title = movie.title
//        self.viewModel?.getMovieInfo(movie: movie) { [weak self] in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.movieDetailTableView?.reloadData()
//            }
//        }
    }
    
    private func configureBinding() {
        viewModel?.movieDetailContents
            .observe(on: MainScheduler.instance)
            .bind(to: movieDetailTableView.rx.items(cellIdentifier: DetailPosterCell.reusableIdentifier, cellType: DetailPosterCell.self)) {
                index, item, cell in
                cell.configure(model: item)
                cell.delegate = self
            }
            .disposed(by: disposeBag)
        
        viewModel?.movieDetailContents
            .observe(on: MainScheduler.instance)
            .bind(to: movieDetailTableView.rx.items(cellIdentifier: DetailContentsCell.reusableIdentifier, cellType: DetailContentsCell.self)) {
                index, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        viewModel?.movieDetailContents
            .observe(on: MainScheduler.instance)
            .bind(to: movieDetailTableView.rx.items(cellIdentifier: DetailCastCell.reusableIdentifier, cellType: DetailCastCell.self)) {
                index, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        viewModel?.movieDetailContents
            .observe(on: MainScheduler.instance)
            .bind(to: movieDetailTableView.rx.items(cellIdentifier: DetailMakeCommentCell.reusableIdentifier, cellType: DetailMakeCommentCell.self)) {
                index, item, cell in
                cell.delegate = self
            }
            .disposed(by: disposeBag)
        
        viewModel?.movieComments
            .observe(on: MainScheduler.instance)
            .bind(to: movieDetailTableView.rx.items(cellIdentifier: DetailCommentCell.reusableIdentifier, cellType: DetailCommentCell.self)) {
                index, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
//        viewModel.movieList
//            .observe(on: MainScheduler.instance)
//            .bind(to: movieListTableView.rx.items(cellIdentifier: MovieListTableViewCell.reusableIdentifier, cellType: MovieListTableViewCell.self)) { index, item, cell in
//
//                cell.configure(model: item)
//            }
//            .disposed(by: disposeBag)
//
//        movieListTableView.rx.modelSelected(Movies.self)
//            .subscribe(onNext: { movie in
//                let movieDetailViewController = MovieDetailsViewController.instantiate()
//                movieDetailViewController.viewModel = MovieDetailViewModel(movies: movie)
//                self.navigationController?.pushViewController(movieDetailViewController, animated: true)
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.movieSortType
//            .subscribe(onNext: { [weak self] in
//                guard let self = self else { return }
//                self.navigationItem.title = $0.title
//            })
//            .disposed(by: disposeBag)
    }
    
    func makeFullImage(isSelected: Bool, image: UIImage) {
        <#code#>
    }
    
    func makeDetailComment(isSelected: Bool) {
        <#code#>
    }
}


// MARK: - UITableViewDelegate
extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.backgroundColor = .gray
    }
}

// MARK: - UITableViewDataSource
extension MovieDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableSectionCounts ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return self.viewModel?.comments?.count ?? 0
        } else {
            return 1
        }
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailPosterCell
//            cell.delegate = self
//            guard let model = self.viewModel?.detailContents, let imageData = self.viewModel?.imageData else { return UITableViewCell() }
//            cell.configure(model: model, imageData: imageData)
//            return cell
//
//        } else if indexPath.section == 1 {
//            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailContentsCell
//            guard let model = self.viewModel?.detailContents else { return UITableViewCell() }
//            cell.configure(with: model)
//            return cell
//
//        } else if indexPath.section == 2 {
//            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailCastCell
//            guard let model = self.viewModel?.detailContents else { return UITableViewCell() }
//            cell.configure(with: model)
//            return cell
//
//        } else if indexPath.section == 3 {
//            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailMakeCommentCell
//            cell.delegate = self
//            return cell
//
//        } else {
//            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailCommentCell
//            guard let model = self.viewModel?.comments?[safe: indexPath.row] else { return UITableViewCell() }
//            cell.configure(with: model)
//            return cell
//
//        }
//    }
//}

extension MovieDetailsViewController: DetailMakeCommentCellDelegate {
    func makeDetailComment(isSelected: Bool) {
        if isSelected {
            let makeCommentsViewController = MakeCommentsViewController.instantiate()
            makeCommentsViewController.delegate = self
            makeCommentsViewController.initialModel(movies: self.viewModel?.movies)
            self.navigationController?.pushViewController(makeCommentsViewController, animated: false)
        }
    }
}

extension MovieDetailsViewController: DetailPosterCellDelegate {
    func makeFullImage(isSelected: Bool, image: UIImage) {
        if isSelected {
            let movieFullImageViewController = MovieFullImageViewController.instantiate()
            movieFullImageViewController.modalPresentationStyle = .fullScreen
            self.present(movieFullImageViewController, animated: false) {
                movieFullImageViewController.configure(with: image)
            }
        }
    }
}

extension MovieDetailsViewController: MakeCommentsViewDelegate {
    func makeComment() {
        guard let movie = self.viewModel?.movies else { return }
        let movieID = movie.id
        self.viewModel?.getComments(movieID: movieID) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieDetailTableView?.reloadData()
            }
        }
    }
}
