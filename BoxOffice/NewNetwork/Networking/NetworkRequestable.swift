//
//  NetworkRequestable.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation
import Alamofire


protocol NetworkRequestable {
    /// Request Path
    var path: String { get }
    /// HttpMethod
    var method: HTTPMethod { get }
    /// Request 시 필요한 parameters
    var parameters: Encodable? { get }
    /// Request Headers
    var headers: HTTPHeaders { get }
    
    /// Endpoint
    /// -  WrongEndPoint Error를 발생시키기 위해 함수로 작성
    func endpoint() throws -> URL
}

// MARK: - Builder
extension NetworkRequestable {
    func endpoint() throws -> URL {
        guard let endpoint = URL(string: baseURL + path) else {
            throw Networking.NetworkingError.wrongEndpoint
        }
        return endpoint
    }
}

// MARK: - Preset

extension NetworkRequestable {
    /// Request 시 사용될 BaseURL
    var baseURL: String {
        "http://connect-boxoffice.run.goorm.io/"
    }
    
    var path: String {
        ""
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Encodable? {
        nil
    }
    
    var headers: HTTPHeaders {
        .default
    }
}


