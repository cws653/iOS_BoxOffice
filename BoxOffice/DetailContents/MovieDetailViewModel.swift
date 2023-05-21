//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/20.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var detailContents: DetailContents? { get set }
    var thumbImageString: String? { get set }
    var comments: [Comment]? { get set }
    var movies: Movies { get set }
    
    func getMovieInfo(completion:@escaping () -> Void)
    func getComments(completion:@escaping () -> Void)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var detailContents: DetailContents?
    var thumbImageString: String?
    var comments: [Comment]?
    var movies: Movies
    
    private let dispatchGroup = DispatchGroup()
    private let service: MovieService
    
    
    init(service: MovieService, movies: Movies) {
        self.service = service
        self.movies = movies
    }
}

extension MovieDetailViewModel {
    func getMovieInfo(completion: @escaping () -> Void) {
        dispatchGroup.enter()
        self.service.getMovieDetail(DetailContents.self, MovieAPI.getMovieDetail(GetMovieDetailRequest(id: self.movies.id))) { result in
            guard let result = result else { return }
            self.detailContents = result
            self.thumbImageString = self.movies.thumb
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getComments {
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func getComments(completion: @escaping () -> Void) {
        self.service.getComments(CommentList.self, MovieAPI.getCommentList(GetMovieCommentsRequest(movieID: self.movies.id))) { result in
            guard let result = result else { return }
            self.comments = result.comments
            completion()
        }
    }
}

