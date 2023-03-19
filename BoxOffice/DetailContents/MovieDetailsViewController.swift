//
//  SecondTableViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/09/01.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController, StoryboardBased {
    static var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
    
    private var viewModel = MovieDetailViewModel()
    private var tableSectionCounts: Int?
    var movie: Movies?
    
    @IBOutlet private weak var movieDetailTableView: UITableView?
    
    @IBOutlet private weak var tableView: UITableView?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.movieDetailTableView?.delegate = self
        self.movieDetailTableView?.dataSource = self        
        self.tableSectionCounts = 5
        
        guard let movie = self.movie else { return }
        self.title = movie.title
        self.viewModel.getMovieInfo(movie: movie) {
            DispatchQueue.main.async {
                self.movieDetailTableView?.reloadData()
            }
        }
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
            return self.viewModel.comments?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
<<<<<<< main
            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailPosterCell
            cell.delegate = self
            guard let model = self.viewModel.detailContents, let imageData = self.viewModel.imageData else { return UITableViewCell() }
            cell.setupUI(model: model, imageData: imageData)
=======
            guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: "DetailViewPosterCell") as? DetailViewPosterCell  else {
                return UITableViewCell()
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            
            cell.imageOfMovie?.isUserInteractionEnabled = true
            cell.imageOfMovie?.addGestureRecognizer(tapGestureRecognizer)
            
            var model: DetailContents
            if self.arrayDetailMovies.isEmpty {
                return .init()
            } else {
                if self.arrayDetailMovies.count > indexPath.row {
                    model = self.arrayDetailMovies[indexPath.row]
                } else {
                    return .init()
                }
            }
            cell.setUI(with: model)
>>>>>>> refactor: IB 객체들 옵셔널 처리
            return cell

        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailContentsCell
            guard let model = self.viewModel.detailContents else { return UITableViewCell() }
            cell.setUI(with: model)
            return cell

        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailCastCell
            guard let model = self.viewModel.detailContents else { return UITableViewCell() }
            cell.setUI(with: model)
            return cell
            
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailMakeCommentCell
            cell.delegate = self
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath) as DetailCommentCell
            guard let model = self.viewModel.comments?[safe: indexPath.row] else { return UITableViewCell() }
            cell.setUI(with: model)
            return cell
            
        }
    }
}

extension MovieDetailsViewController: DetailMakeCommentCellDelegate {
    func makeDetailComment(isSelected: Bool) {
        if isSelected {
            let makeCommentsViewController = MakeCommentsViewController.instantiate()
            makeCommentsViewController.delegate = self
            makeCommentsViewController.movies = self.movie
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
                movieFullImageViewController.fullScreen.image = image
            }
        }
    }
}

extension MovieDetailsViewController: MakeCommentsViewDelegate {
    func makeComment() {
        guard let movieID = self.movie?.id else { return }
        self.viewModel.getComments(movieID: movieID) {
            DispatchQueue.main.async {
                self.movieDetailTableView?.reloadData()
            }
        }
    }
}
