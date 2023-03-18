//
//  ViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/08/26.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class MovieListTableViewController: UIViewController{
    
    private let movieService: MovieServiceProvider = .shared
//    private let cellIdentifier: String = "tableViewCell"
    var arrayMovies: [Movies] = []

    @IBOutlet private weak var movieListTableView: UITableView?

    @IBAction private func navigationItemAction(_ sender: UIBarButtonItem) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = .systemIndigo
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        
        self.movieService.requestMovieList(movieSortMode: .reservationRate) { movies in
            DispatchQueue.main.async {
                self.arrayMovies = movies
                self.movieListTableView?.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.movieListTableView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.movieListTableView?.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let navigationController = self.tabBarController?.viewControllers?[1] as? UINavigationController {
            if let movieListCollectionViewController = navigationController.viewControllers.first as? MovieListCollectionViewController {
                movieListCollectionViewController.arrayMovies = self.arrayMovies
                movieListCollectionViewController.navigationItem.title = self.navigationItem.title
            }
        }
    }
    
    private func showAlertController (style: UIAlertController.Style) {
        let alertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: style)

        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction) in print("취소버튼 선택")})
        
        alertController.addAction(alertActionSetting(movieSortMode: .reservationRate))
        alertController.addAction(alertActionSetting(movieSortMode: .quration))
        alertController.addAction(alertActionSetting(movieSortMode: .open))
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: { print("Alert controller shown")})
    }

    private func alertActionSetting(movieSortMode: MovieSortMode) -> UIAlertAction {
        let alertAction = UIAlertAction(title: movieSortMode.title, style: UIAlertAction.Style.default) { _ in
            self.movieService.requestMovieList(movieSortMode: movieSortMode) { movies in
                DispatchQueue.main.async {
                    self.navigationItem.title = movieSortMode.title
                    self.arrayMovies = movies
                    self.movieListTableView?.reloadData()
                }
            }
        }
        return alertAction
    }
}

// MARK: - UITableViewDelegeate
extension MovieListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailsViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsViewController {
            movieDetailsViewController.movies = self.arrayMovies[indexPath.row]

            self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension MovieListTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell: MovieListTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? MovieListTableViewCell else {
//            return UITableViewCell()
//        }
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieListTableViewCell
        
        let model = self.arrayMovies[indexPath.row]
        
        guard let imageURL: URL = URL(string: model.thumb) else {
            return UITableViewCell()
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                cell.setupUI(model: model, data: data)
            }
        }.resume()
        
        return cell
    }
}





