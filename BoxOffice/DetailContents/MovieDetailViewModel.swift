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
    
    let dispatchGroup = DispatchGroup()
}

extension MovieDetailViewModel {
    func getMovieInfo(movie: Movies, completion:@escaping () -> Void) {
        dispatchGroup.enter()
        MovieServiceProvider.shared.getMovieDetails(movieId: movie.id) { [weak self] detailContent in
            guard let self = self else { return }
            self.detailContents = detailContent
            self.getImageData(from: movie) {
                self.dispatchGroup.leave()
                completion()
            }
        }
        
        MovieServiceProvider.shared.getCommentList(movieId: movie.id) { commentList in
            self.comments = commentList?.comments
            completion()
        }
    }
    
    func getImageData(from movie: Movies, completion:@escaping () -> Void) {
        guard let imageURL = URL(string: movie.thumb) else {
            return
        }
        MovieServiceProvider.shared.getMovieImageData(url: imageURL) { data in
            self.imageData = data
            completion()
        }
    }
    
    func getComments(movieID: String, completion:@escaping () -> Void) {
        MovieServiceProvider.shared.getCommentList(movieId: movieID) { commentList in
            self.comments = commentList?.comments
            completion()
        }
    }
}

