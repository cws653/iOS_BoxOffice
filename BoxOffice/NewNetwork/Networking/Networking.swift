//
//  Networking.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation
import Alamofire

protocol NetworkingProtocol {
    func request<T:Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Error>) -> ())
    )
    func requestMultipartFormData<T:Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Error>) -> ())
    )
}

final class Networking: NetworkingProtocol {
    
    enum NetworkingError: Error {
        case emptyResponse
        case wrongRequest
        case wrongEndpoint
        case response(AFError)
    }
    
    func request<T>(_ model: T.Type, _ requestable: NetworkRequestable, _ completion: @escaping ((Result<T?, Error>) -> ())) where T : Decodable {
        do {
            let endpoint = try requestable.endpoint()
            let parameters = requestable.parameters?.requestable ?? [:]
            AF.request(
                endpoint,
                method: requestable.method,
                parameters: parameters,
                headers: requestable.headers
            ).response { response in
                if let error = response.error {
                    completion(.failure(NetworkingError.response(error)))
                }
                guard let data = response.data else {
                    completion(.failure(NetworkingError.emptyResponse))
                    return
                }
                
                self.decode(model, data, { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            completion(.success(success))
                        case .failure(let failure):
                            completion(.failure(failure))
                        }
                    }
                })
            }
        } catch {
            self.requestErrorHandling(error)
            completion(.failure(NetworkingError.wrongRequest))
        }
    }
    
    func requestMultipartFormData<T>(_ model: T.Type, _ requestable: NetworkRequestable, _ completion: @escaping ((Result<T?, Error>) -> ())) where T : Decodable {
        do {
            let endPoint = try requestable.endpoint()
            let parameters = requestable.parameters?.multiPartRequestable ?? [:]
            AF.upload(
                multipartFormData: { multipartFormData in
                    for (key, value) in parameters {
                        if key == "image" {
                            multipartFormData.append(
                                value,
                                withName: "image",
                                fileName: "file.png",
                                mimeType: "image/png"
                            )
                        } else {
                            multipartFormData.append(
                                value,
                                withName: key,
                                fileName: key,
                                mimeType: "application/json"
                            )
                        }
                    }
                },
                to: endPoint,
                headers: requestable.headers
            ) {
                $0.timeoutInterval = 10
            }
            .response { response in
                if let error = response.error {
                    completion(.failure(NetworkingError.response(error)))
                }
                guard let data = response.data else {
                    completion(.failure(NetworkingError.emptyResponse))
                    return
                }
                
                self.decode(model, data, { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            completion(.success(success))
                        case .failure(let failure):
                            completion(.failure(failure))
                        }
                    }
                })
            }
        } catch {
            self.requestErrorHandling(error)
            completion(.failure(NetworkingError.wrongRequest))
        }
    }
}

extension Networking {
    private func requestErrorHandling(_ error: Error) {
        guard let error = error as? NetworkingError else {
            debugPrint("** Unhandled error occurs \(error.localizedDescription)")
            return
        }
        
        switch error {
        case .wrongEndpoint:
            debugPrint("** WrongEndPointError occurs")
        case .wrongRequest:
            debugPrint("** WrongRequestError occurs")
        default:
            debugPrint("** UnhandledReuqestError occurs")
        }
    }
    
    private func decode<T: Decodable>(_: T.Type ,_ data: Data, _ completion: @escaping ((Result<T?, Error>) -> ()))  {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch (let error) {
            debugPrint("Error: JSONDecode \(error)")
            completion(.failure(NetworkingError.emptyResponse))
        }
    }
}
