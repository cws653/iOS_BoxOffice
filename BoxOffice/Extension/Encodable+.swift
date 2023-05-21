//
//  Encodable+.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation
import Alamofire

extension Encodable {
    var requestable: Parameters {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
        
//        if let bodyParameters = try bodyParameters?.toDictionary() {
//            if !bodyParameters.isEmpty {
//                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
//            }
//        }
    }
    
    var multiPartRequestable: [String: Data] {
        do {
            let data = try JSONEncoder().encode(self)
            guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return [:]
            }
            
            var dictionary: [String: Data] = [:]
            for (key, value) in jsonObject {
                if let valueString = value as? String {
                    dictionary.updateValue(Data(base64Encoded: valueString) ?? Data(), forKey: key)
                } else {
                    let serializedData = try? JSONSerialization.data(withJSONObject: value, options: .fragmentsAllowed)
                    dictionary.updateValue(serializedData ?? Data(), forKey: key)
                }
            }
            return dictionary
        } catch {
            return [:]
        }
    }
}
