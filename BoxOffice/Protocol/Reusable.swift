//
//  Reusable.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/18.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

protocol Reusable: AnyObject {
    static var reusableIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.reusableIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue a cell with identifier: \(T.reusableIdentifier)")
        }

        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.reusableIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue a cell with identifier: \(T.reusableIdentifier)")
        }

        return cell
    }
}

