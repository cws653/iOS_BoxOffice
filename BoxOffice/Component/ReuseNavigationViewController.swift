//
//  ReuseNavigationViewController.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

class ReuseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemIndigo
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationBar.tintColor = .white
    }
}
