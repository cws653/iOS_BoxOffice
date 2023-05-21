//
//  MovieRepositoryLogic.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/15.
//

import Foundation

protocol MovieRepositoryLogic {
    
}

final class MovieRepository: MovieRepositoryLogic {
    private let movieService: MovieServiceLogic
    
    init(_ movieService: MovieServiceLogic) {
        self.movieService = movieService
    }
    
    func fetchMovieList(
        _ model: GetMovieListRequest ,
        _ completion: @escaping (MovieList) -> ()
    ) {
        
    }
}
