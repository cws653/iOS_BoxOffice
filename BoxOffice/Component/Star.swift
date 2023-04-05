//
//  Star.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/26.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

final class Star: UIView, NibBased {
    
    @IBOutlet private weak var firstStar: UIImageView?
    @IBOutlet private weak var secondStar: UIImageView?
    @IBOutlet private weak var thirdStar: UIImageView?
    @IBOutlet private weak var fourthStar: UIImageView?
    @IBOutlet private weak var fifthStar: UIImageView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    func setupView(rateValue: Double) {
        let stars = makeStarImage(with: rateValue)
        self.firstStar?.image = stars[safe: 0] as? UIImage
        self.secondStar?.image = stars[safe: 1] as? UIImage
        self.thirdStar?.image = stars[safe: 2] as? UIImage
        self.fourthStar?.image = stars[safe: 3] as? UIImage
        self.fifthStar?.image = stars[safe: 4] as? UIImage
    }
    
    private func makeStarImage(with rateValue: Double) -> [UIImage?] {
        let roundValue = round(rateValue)
        let defaultStar = UIImage(named: "ic_star_large")
        let halfStar = UIImage(named: "ic_star_large_half")
        let fullStar = UIImage(named: "ic_star_large_full")
        
        switch roundValue {
        case 0:
            return [defaultStar, defaultStar, defaultStar, defaultStar, defaultStar]
        case 1.0:
            return [halfStar, defaultStar, defaultStar, defaultStar, defaultStar]
        case 2.0:
            return [fullStar, defaultStar, defaultStar, defaultStar, defaultStar]
        case 3.0:
            return [fullStar, halfStar, defaultStar, defaultStar, defaultStar]
        case 4.0:
            return [fullStar, fullStar, defaultStar, defaultStar, defaultStar]
        case 5.0:
            return [fullStar, fullStar, halfStar, defaultStar, defaultStar]
        case 6.0:
            return [fullStar, fullStar, fullStar, defaultStar, defaultStar]
        case 7.0:
            return [fullStar, fullStar, fullStar, halfStar, defaultStar]
        case 8.0:
            return [fullStar, fullStar, fullStar, fullStar, defaultStar]
        case 9.0:
            return [fullStar, fullStar, fullStar, fullStar, halfStar]
        case 10.0:
            return [fullStar, fullStar, fullStar, fullStar, fullStar]
        default:
            return [nil, nil, nil, nil, nil]
        }
    }
}
