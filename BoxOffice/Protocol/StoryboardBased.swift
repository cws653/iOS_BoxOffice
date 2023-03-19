//
//  StoryboardBased.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

protocol StoryboardBased: AnyObject {
    static var storyboard: UIStoryboard { get }
    static func instantiate() -> Self
}

extension StoryboardBased where Self: UIViewController {
    static func instantiate() -> Self {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
            fatalError("Could not find a \(self)")
        }
        return viewController
    }
}
