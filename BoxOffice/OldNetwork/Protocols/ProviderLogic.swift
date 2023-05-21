//
//  Provider.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/21.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

protocol ProviderLogic {
    func request<R: Decodable, E: RequestResponsable>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R

    func request(_ url: URL, completion: @escaping (Result<Data, Error>) -> ())
}
