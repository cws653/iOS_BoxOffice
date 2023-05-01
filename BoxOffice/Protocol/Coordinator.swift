//
//  Coordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/30.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
