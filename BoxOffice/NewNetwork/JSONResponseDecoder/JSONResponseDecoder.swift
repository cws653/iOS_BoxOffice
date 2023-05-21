//
//  JSONResponseDecoder.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation

protocol JSONResponseDecodable {
    func deocde<T: Decodable>(_: T.Type, _ jsonData: Data, _ completion: @escaping ((Result<T?, Error>) -> ()))
}

struct JSONResponseDecoder {
    enum JSONResponseDecoderError: Error {
        case decodeFailed
    }
}

extension JSONResponseDecoder: JSONResponseDecodable {
    func deocde<T: Decodable>(_: T.Type, _ jsonData: Data, _ completion: @escaping ((Result<T?, Error>) -> ()))  {
        do {
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            completion(.success(result))
        } catch (let error) {
            debugPrint("Error: JSONDecode \(error)")
            completion(.failure(JSONResponseDecoderError.decodeFailed))
        }
    }
}
