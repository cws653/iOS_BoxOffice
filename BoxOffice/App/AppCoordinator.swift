//
//  AppCoordinator.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/30.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = ReuseNavigationViewController()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
    }
}


