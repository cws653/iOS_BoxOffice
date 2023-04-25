//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/20.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

class MovieDetailViewModel {

    private(set) var detailContents: DetailContents?
    private(set) var imageData: Data?
    private(set) var comments: [Comment]?
    private(set) var movies: Movies?
    
    private let dispatchGroup = DispatchGroup()
    private let provider = Provider()
}

extension MovieDetailViewModel {
    func setMovies(with movies: Movies) {
        self.movies = movies
    }
    
    func getMovieInfo(movie: Movies, completion:@escaping () -> Void) {
        let movieID = movie.id
        let endPoint = APIEndpoints.getMovieDetails(movieID: movieID)
        self.provider.request(with: endPoint) { result in
            switch result {
            case .success(let detailContents):
                self.detailContents = detailContents
                self.getImageData(from: movie) {
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        self.getComments(movieID: movie.id) {
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
    
    func getComments(movieID: String, completion:@escaping () -> Void) {
        let endPoint = APIEndpoints.getCommentList(movieID: movieID)
        self.provider.request(with: endPoint) { result in
            switch result {
            case .success(let commentList):
                self.comments = commentList.comments
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}

