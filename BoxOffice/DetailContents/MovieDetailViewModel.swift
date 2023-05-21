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
    var imageData: Data? { get set }
    var comments: [Comment]? { get set }
    var movies: Movies { get set }
    
    func getMovieInfo(completion:@escaping () -> Void)
    func getImageData(from movie: Movies, completion:@escaping () -> Void)
    func getComments(completion:@escaping () -> Void)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var detailContents: DetailContents?
    var imageData: Data?
    var comments: [Comment]?
    var movies: Movies
    
    private let dispatchGroup = DispatchGroup()
    private let provider = Provider()
    private let service: MovieService
    
    
    init(service: MovieService, movies: Movies) {
        self.service = service
        self.movies = movies
    }
}

extension MovieDetailViewModel {
    func getMovieInfo(completion: @escaping () -> Void) {
        self.service.getMovieDetail(DetailContents.self, MovieAPI.getMovieDetail(GetMovieDetailRequest(id: self.movies.id))) { result in
            guard let result = result else { return }
            self.detailContents = result
            self.getImageData(from: self.movies) {
                completion()
            }
        }
        
        self.getComments {
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
    
    func getImageData(from movie: Movies, completion:@escaping () -> Void) {
        guard let imageURL = URL(string: movie.thumb) else {
            return
        }
        
        self.provider.request(imageURL) { result in
            switch result {
            case .success(let data):
                self.imageData = data
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}

