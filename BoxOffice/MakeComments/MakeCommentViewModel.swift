//
//  MakeCommentViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/22.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

class MakeCommentViewModel {
    
    private(set) var movies: Movies?
    
    let provider = Provider()
}

extension MakeCommentViewModel {
    
    func initMovies(movies: Movies) {
        self.movies = movies
    }
    
    func postComment(request: PostMovieCommentRequest, completion: @escaping () -> Void) {
        let endPoint = APIEndpoints.postComment(request: request)
        self.provider.request(with: endPoint) { result in
            switch result {
            case .success(let comment):
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
