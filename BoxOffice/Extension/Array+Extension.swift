//
//  Array+Extension.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/20.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
