//
//  MovieListTableViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol MovieListViewModelProtocol {
    var movieList: [Movies] { get set }
    var imageData: [Data] { get set }
    func getMovieList(movieOrderType: Int, completion: @escaping () -> Void)
}

final class MovieListTableViewModel: MovieListViewModelProtocol {
    var movieList: [Movies] = []
    var imageData: [Data] = []
    
    var testMovieList = CurrentValueSubject<[Movies], Never>([])
    @Published test: [Movie] = []
    private var cancellables = Set<AnyCancellable>()
    
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
    
    func testGetMovieList(movieOrderType: Int) {
        self.service.getMovieListCB(MovieList.self, MovieAPI.getMovieList(GetMovieListRequest(orderType: movieOrderType)))
            .map { $0.movies }
            .assign(to: \.movies, on: self.testMovieList)
            .store(in: &cancellables)
    }
    
    
worker: movielsitworkerprotocol
    
    init() {
        worker.test.subscribe { value in
            // 어떻게 변경된값을 처리할것인지
            presenter.showMovieList(value)
        }
    }
    
    func onViewDidload() {
        worker.testGetMovieList()
    }
    
}

movielsitworkerprotocol {
    @Published test: [Movie] { get }
}

worker: movielsitworkerprotocol {
    
    func testGetMovieList(movieOrderType: Int) {
        self.service.getMovieListCB(MovieList.self, MovieAPI.getMovieList(GetMovieListRequest(orderType: movieOrderType)))
            .map { $0.movies }
            .assign(to: \.movies, on: self.test)
            .store(in: &cancellables)
    }
}

//struct viewmodel {
//}