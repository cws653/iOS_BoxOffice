//
//  MakeCommentViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/22.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

protocol makeCommentViewModelProtocol {
    var movies: Movies { get set }
    func postComment(request: PostMovieCommentRequest, completion: @escaping () -> Void)
}

class MakeCommentViewModel: makeCommentViewModelProtocol {
    
    var movies: Movies
    
    private let provider = Provider()
    private let service: MovieService
    
    init(movies: Movies, service: MovieService) {
        self.movies = movies
        self.service = service
    }
}

extension MakeCommentViewModel {
    func postComment(request: PostMovieCommentRequest, completion: @escaping () -> Void) {
        self.service.postComments(Comment.self, MovieAPI.postComment(request)) { result in
            guard let result = result else { return }
            completion()
        }
    }
}
