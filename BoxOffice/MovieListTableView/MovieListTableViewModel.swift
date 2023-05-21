//
//  MovieListTableViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

protocol MovieListViewModelProtocol {
    var movieList: [Movies] { get set }
    var imageData: [Data] { get set }
    func getMovieList(movieOrderType: Int, completion: @escaping () -> Void)
}

final class MovieListTableViewModel: MovieListViewModelProtocol {
    var movieList: [Movies] = []
    var imageData: [Data] = []
    
    private let service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
}

extension MovieListTableViewModel {
    func getMovieList(movieOrderType: Int, completion: @escaping () -> Void) {
        self.service.getMovieList(MovieList.self, MovieAPI.getMovieList(GetMovieListRequest(orderType: movieOrderType))) { result in
            guard let result = result else { return }
            self.movieList = result.movies
            completion()
        }
    }
}
