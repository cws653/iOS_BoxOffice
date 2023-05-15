//
//  MovieListTableViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation
import RxSwift

final class MovieListTableViewModel {
    let disposeBag = DisposeBag()
    
    var movieSortType = BehaviorSubject<MovieSortType>(value: .reservationRate)
    var movieList = BehaviorSubject<[Movies]>(value: [])
    let provider = Provider()
    
    init() {
        
        movieSortType
            .subscribe(onNext: { [weak self] in
                self?.fetchMovieList($0)
            })
            .disposed(by: disposeBag)
    }
}

extension MovieListTableViewModel {
    func fetchMovieList(_ type: MovieSortType) {
        let endPoint = APIEndpoints.getMovieList(movieSortType: type)
        provider.reqeustRx(with: endPoint)
            .map { $0.movies }
            .bind(to: movieList)
            .disposed(by: disposeBag)
    }
    
    func getMovieSortType(with movieSortType: MovieSortType) {
        self.movieSortType.onNext(movieSortType)
    }
}
