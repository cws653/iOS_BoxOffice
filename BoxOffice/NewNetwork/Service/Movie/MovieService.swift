//
//  MovieService.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation
import Combine

protocol MovieServiceLogic {
    
    func getMovieList<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T, Error>
    )
    
    func getMovieDetail<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T, Error>
    )
    
    func getComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T, Error>
    )
    
    func postComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T, Error>
    )
}

final class MovieService {
    private let networking: NetworkingProtocol
    
    init(_ networking: NetworkingProtocol) {
        self.networking = networking
    }
}

extension MovieService: MovieServiceLogic {
    
    func getMovieList<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable
    ) -> AnyPublisher<T, Error> {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getMovieDetail<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable
    ) -> AnyPublisher<T, Error> {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable
    ) -> AnyPublisher<T, Error> {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func postComments<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable
    ) -> AnyPublisher<T, Error> {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
