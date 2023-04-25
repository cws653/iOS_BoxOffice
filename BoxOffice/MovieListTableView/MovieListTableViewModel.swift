//
//  MovieListTableViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

final class MovieListTableViewModel {
    
    private(set) var movieList: [Movies]?
    private(set) var imageData: [Data] = []
    
    private let dispatchGroup = DispatchGroup()
    private let provider = Provider()
}

extension MovieListTableViewModel {
    
    func getMoviewList(movieMode: MovieSortMode, completion: @escaping () -> Void) {
        let endPoint = APIEndpoints.getMovieList(movieSortType: movieMode)
        self.provider.request(with: endPoint) { result in
            switch result {
            case .success(let movieList):
                self.movieList = movieList.movies
                self.getImageDatas(from: movieList.movies) {
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImageDatas(from movies: [Movies], completion:@escaping () -> Void) {
        movies.forEach { movie in
            dispatchGroup.enter()
            guard let imageURL = URL(string: movie.thumb) else {
                return
            }
            self.provider.request(imageURL) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.imageData.append(data)
                    self?.dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
}
