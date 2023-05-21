//
//  HttpHeader+.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/15.
//

import UIKit

import Alamofire

extension HTTPHeaders {
    static var `default`: HTTPHeaders {
        HTTPHeaders([
            "Authorization" : UIDevice.current.identifierForVendor?.description ?? .init().description
        ])
    }
    
    static var multipartHeader: HTTPHeaders {
        var headers = HTTPHeaders.default
        headers.update(.contentType("multipart/form-data"))
        return headers
    }
}

