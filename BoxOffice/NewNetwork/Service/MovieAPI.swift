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
}

extension MovieAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .getMovieList:
            return "movies"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getMovieList:
            return .default
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovieList:
            return .get
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .getMovieList(let model):
            return model
        }
    }
}
