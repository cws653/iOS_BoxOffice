//
//  URLSessionable.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/21.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

protocol URLSessionable {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionable {}
