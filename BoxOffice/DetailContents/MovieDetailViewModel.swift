//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/20.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailViewModel {
    
    let disposeBag = DisposeBag()
    
    var movie = PublishSubject<Movies>()
    var movieDetailContents = PublishSubject<[DetailContents]>()
    var movieComments = PublishSubject<[Comment]>()
    private let provider = Provider()
    
    var tableViewSectionCount: Int?
    
//    private(set) var detailContents: DetailContents?
//    private(set) var imageData: Data?
//    private(set) var comments: [Comment]?
//    private(set) var movies: Movies?
//
//    private let dispatchGroup = DispatchGroup()

    
    init(movies: Movies) {
        movie.onNext(movies)
        
        movie
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.fetchMovieDetailInfo($0)
                self.fetchMovieComments($0)
            })
            .disposed(by: disposeBag)
    }
}

extension MovieDetailViewModel {
    func fetchMovieDetailInfo(_ movie: Movies) {
        let movieID = movie.id
        let endPoint = APIEndpoints.getMovieDetails(movieID: movieID)
        provider.reqeustRx(with: endPoint)
            .map { [$0] }
            .bind(to: movieDetailContents)
            .disposed(by: disposeBag)
    }
    
    func fetchMovieComments(_ movie: Movies) {
        let movieID = movie.id
        let endPoint = APIEndpoints.getCommentList(movieID: movieID)
        provider.reqeustRx(with: endPoint)
            .map { $0.comments }
            .bind(to: movieComments)
            .disposed(by: disposeBag)
    }
    
    func getComments(movieID: String, completion:@escaping () -> Void) {
        let endPoint = APIEndpoints.getCommentList(movieID: movieID)
        provider.reqeustRx(with: endPoint)
            .map { $0.comments }
            .bind(to: movieComments)
            .disposed(by: disposeBag)
    }
    
//    func getMovieInfo(movie: Movies, completion:@escaping () -> Void) {
//        let movieID = movie.id
//        let endPoint = APIEndpoints.getMovieDetails(movieID: movieID)
//        self.provider.request(with: endPoint) { result in
//            switch result {
//            case .success(let detailContents):
//                self.detailContents = detailContents
//                self.getImageData(from: movie) {
//                    completion()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        self.getComments(movieID: movie.id) {
//            completion()
//        }
//    }
    
//    func getImageData(from movie: Movies, completion:@escaping () -> Void) {
//        guard let imageURL = URL(string: movie.thumb) else {
//            return
//        }
//
//        self.provider.request(imageURL) { result in
//            switch result {
//            case .success(let data):
//                self.imageData = data
//                completion()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    func getComments(movieID: String, completion:@escaping () -> Void) {
//        let endPoint = APIEndpoints.getCommentList(movieID: movieID)
//        self.provider.request(with: endPoint) { result in
//            switch result {
//            case .success(let commentList):
//                self.comments = commentList.comments
//                completion()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}

