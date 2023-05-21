//
//  MovieAPI.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/14.
//

import Foundation
import Alamofire
import UIKit

enum MovieAPI {
    case getMovieList(GetMovieListRequest)
    case getMovieDetail(GetMovieDetailRequest)
    case getCommentList(GetMovieCommentsRequest)
    case postComment(PostMovieCommentRequest)
}

extension MovieAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .getMovieList:
            return "movies"
        case .getMovieDetail:
            return "movie"
        case .getCommentList:
            return "comments"
        case .postComment:
            return "comment"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getMovieList:
            return .default
        case .getMovieDetail:
            return .default
        case .getCommentList:
            return .default
        case .postComment:
            return .default
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovieList:
            return .get
        case .getMovieDetail:
            return .get
        case .getCommentList:
            return .get
        case .postComment:
            return .post
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .getMovieList(let model):
            return model
        case .getMovieDetail(let model):
            return model
        case .getCommentList(let model):
            return model
        case .postComment(let model):
            return model
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getMovieList(_):
            return URLEncoding.default
        case .getMovieDetail(_):
            return URLEncoding.default
        case .getCommentList(_):
            return URLEncoding.default
        case .postComment(_):
            return JSONEncoding.default
        }
    }
}
