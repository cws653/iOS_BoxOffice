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
        dispatchGroup.enter()
        let endPoint = APIEndpoints.getMovieList(movieSortType: movieMode)
        self.provider.request(with: endPoint) { result in
            switch result {
            case .success(let movieList):
                self.movieList = movieList.movies
                self.getImageDatas(from: movieList.movies) {
                    self.dispatchGroup.leave()
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImageDatas(from movies: [Movies], completion:@escaping () -> Void) {
        movies.forEach { movie in
            guard let imageURL = URL(string: movie.thumb) else {
                return
            }
            self.provider.request(imageURL) { result in
                switch result {
                case .success(let data):
                    self.imageData.append(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
        completion()
    }
}
