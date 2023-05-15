//
//  UIView+Extension.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/05/06.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
