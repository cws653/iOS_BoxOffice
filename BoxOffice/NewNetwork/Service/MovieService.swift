//
//  MovieService.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation

protocol MovieServiceLogic {
    typealias RepositoryList = MovieList
    
    func getMovieList(
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((RepositoryList?) -> ())
    )
}

final class MovieService {
    private let networking: NetworkingProtocol
    
    init(_ networking: NetworkingProtocol) {
        self.networking = networking
    }
}

extension MovieService: MovieServiceLogic {
    func getMovieList(
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((RepositoryList?) -> ())
    ) {
        networking.request(RepositoryList.self, requestable) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure:
                completion(nil)
            }
        }
    }
}
