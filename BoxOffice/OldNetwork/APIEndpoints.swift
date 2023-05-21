//
//  APIEndpoints.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/21.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

struct APIEndpoints {
    static func getMovieList(movieSortType: MovieSortMode) -> EndPoint<MovieList> {
        return EndPoint(path: "movies",
                        method: .get,
                        queryParameters: GetMovieListRequest(orderType: movieSortType.rawValue)
                        )
    }

    static func getMovieDetails(movieID: String) -> EndPoint<DetailContents> {
        return EndPoint(path: "movie",
                        method: .get,
                        queryParameters: GetMovieDetailRequest(id: movieID)
                        )
    }
    
    static func getCommentList(movieID: String) -> EndPoint<CommentList> {
        return EndPoint(path: "comments",
                        method: .get,
                        queryParameters: GetMovieCommentsRequest(movieID: movieID)
                        )
    }
    
    static func postComment(request: PostMovieCommentRequest) -> EndPoint<Comment> {
        return EndPoint(path: "comment",
                        method: .post,
                        bodyParameters: request
                        )
    }
}
