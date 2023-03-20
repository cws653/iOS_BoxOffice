//
//  Grade.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

enum Grade: Int {
    case zero = 0
    case twelve = 12
    case fifteen = 15
    case nineteen = 19
}

extension Grade {
    var image: UIImage? {
        switch self {
        case .zero:
            return UIImage(named: "ic_allages")
        case .twelve:
            return UIImage(named: "ic_12")
        case .fifteen:
            return UIImage(named: "ic_15")
        case .nineteen:
            return UIImage(named: "ic_19")
        }
    }
}
