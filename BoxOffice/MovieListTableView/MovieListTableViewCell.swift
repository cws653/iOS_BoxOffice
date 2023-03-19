//
//  CustomTableViewCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/08/29.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet private weak var thumbImageView: UIImageView?
    @IBOutlet private weak var gradeImageView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var rateLabel: UILabel?
    @IBOutlet private weak var openDateLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.thumbImageView?.image = nil
        self.gradeImageView?.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.thumbImageView?.image = nil
        self.gradeImageView?.image = nil
    }

    func setupUI(model: Movies, thumbnailData: Data) {
        self.thumbImageView?.image = UIImage(data: thumbnailData)
        self.gradeImageView?.image = Grade(rawValue: model.grade)?.image
        self.titleLabel?.text = model.title
        self.rateLabel?.text = "예매율: " + String(model.reservationRate) + " " + "예매순위: " + String(model.reservationGrade) + " " + String(model.userRating)
        self.openDateLabel?.text = "개봉일: " + String(model.date)
    }
}

enum Grade: Int {
    case zero = 0
    case twelve = 12
    case fifteen = 15
    case nineteen = 19
    
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
