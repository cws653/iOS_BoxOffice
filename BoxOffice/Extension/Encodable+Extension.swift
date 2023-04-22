//
//  Encodable+Extension.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/21.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
