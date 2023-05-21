//
//  MovieListCollectionViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

final class MovieListCollectionViewModel: MovieListViewModelProtocol {
    var movieList: [Movies] = []
    var imageData: [Data] = []
    
    private let dispatchGroup = DispatchGroup()
    private let provider = Provider()
    private let service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
}

extension MovieListCollectionViewModel {
    func getMovieList(movieOrderType: Int, completion: @escaping () -> Void) {
        self.service.getMovieList(MovieList.self, MovieAPI.getMovieList(GetMovieListRequest(orderType: movieOrderType))) { result in
            guard let result = result else { return }
            self.movieList = result.movies
            self.getImageDatas(from: result.movies) {
                completion()
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
