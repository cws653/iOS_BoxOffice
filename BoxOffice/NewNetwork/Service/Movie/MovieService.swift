//
//  MovieService.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation

protocol MovieServiceLogic {
    
    func getMovieList<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    )
    
    func getMovieDetail<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    )
    
    func getComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    )
    
    func postComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    )
}

final class MovieService {
    private let networking: NetworkingProtocol
    
    init(_ networking: NetworkingProtocol) {
        self.networking = networking
    }
}

extension MovieService: MovieServiceLogic {
    
    func getMovieList<T:Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    ) {
        networking.request(T.self, requestable) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getMovieDetail<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    ) {
        networking.request(T.self, requestable) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    ) {
        networking.request(T.self, requestable) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func postComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((T?) -> ())
    ) {
        networking.request(T.self, requestable) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure:
                completion(nil)
            }
        }
    }
}
