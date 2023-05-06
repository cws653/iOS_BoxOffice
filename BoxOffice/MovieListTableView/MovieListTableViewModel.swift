//
//  MovieListTableViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class MovieListTableViewModel {
    let disposeBag = DisposeBag()
    
    var movieSortType = BehaviorRelay<MovieSortMode>(value: .reservationRate)
    var movieList = BehaviorSubject<[Movies]>(value: [])
    var movieData = BehaviorSubject<[Data]>(value: [])
    
//    private(set) var movieList: [Movies]?
//    private(set) var imageData: [Data] = []
    
    private let dispatchGroup = DispatchGroup()
    //    private let provider = Provider()
    
    init(provider: Provider = Provider()) {
        
        let fetchingMovieList = PublishSubject<Void>()
        let fetchingMovieImagesData = PublishSubject<Void>()
        
        //        let movieList = BehaviorSubject<[Movies]>(value: [])
        
        movieSortType
            .map { [weak self] in
                let endPoint = APIEndpoints.getMovieList(movieSortType: $0)
                provider.reqeustRx(with: endPoint)
                    .map {
                        $0.movies
                    }
                    .map { [weak self] movies in
                        var temp: [Movies] = []
                        movies.map { movie in
                            guard let imageURL = URL(string: movie.thumb) else { return }
                            provider.requestRx(with: imageURL)
                                .map {
                                    temp.append(Movies(grade: movie.grade, thumb: movie.thumb, reservationGrade: movie.reservationGrade, title: movie.title, reservationRate: movie.reservationRate, userRating: movie.userRating, date: movie.date, id: movie.id, imageData: $0))
                                }
                        }
                        return temp
                    }
                    .take(1)
                    .subscribe(onNext: {
                        self?.movieList.onNext($0)
                    })
            }
        
        movieList
            .map { [weak self] movies in
                var temp: [Data] = []
                movies.map { movie in
                    guard let imageURL = URL(string: movie.thumb) else { return }
                    provider.requestRx(with: imageURL)
                        .map {
//                            Movies(grade: movie.grade, thumb: movie.thumb, reservationGrade: movie.reservationGrade, title: movie.title, reservationRate: movie.reservationRate, userRating: movie.userRating, date: movie.date, id: movie.id, imageData: $0)
                            temp.append($0)
                        }
                }
                return temp
            }
            .subscribe(onNext: {
                self.movieData.onNext($0)
            })
    }
}

//extension MovieListTableViewModel {
//
//    func getMoviewList(movieMode: MovieSortMode, completion: @escaping () -> Void) {
//        let endPoint = APIEndpoints.getMovieList(movieSortType: movieMode)
//        self.provider.request(with: endPoint) { result in
//            switch result {
//            case .success(let movieList):
//                self.movieList = movieList.movies
//                self.getImageDatas(from: movieList.movies) {
//                    completion()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//    func getImageDatas(from movies: [Movies], completion:@escaping () -> Void) {
//        movies.forEach { movie in
//            dispatchGroup.enter()
//            guard let imageURL = URL(string: movie.thumb) else {
//                return
//            }
//            self.provider.request(imageURL) { [weak self] result in
//                switch result {
//                case .success(let data):
//                    self?.imageData.append(data)
//                    self?.dispatchGroup.leave()
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//        dispatchGroup.notify(queue: .main) {
//            completion()
//        }
//    }
//}
