//
//  CustomCollectionViewCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet private weak var movieImageView: UIImageView?
    @IBOutlet private weak var gradeImageView: UIImageView?
    @IBOutlet private weak var movieTitleLabel: UILabel?
    @IBOutlet private weak var gradeAndRateLabel: UILabel?
    @IBOutlet private weak var openDateLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.movieImageView?.image = nil
        self.gradeImageView?.image = nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.movieImageView?.image = nil
        self.gradeImageView?.image = nil
    }

    func setupUI(model: Movies?, thumbnailData: Data?) {
        guard let model = model, let thumbnailData = thumbnailData else { return }
        
        self.movieImageView?.image = UIImage(data: thumbnailData)
        self.gradeImageView?.image = Grade(rawValue: model.grade)?.image
        
        self.movieTitleLabel?.text = model.title
        self.gradeAndRateLabel?.text = String(model.reservationGrade) + "위" + "(" + String(model.userRating) + ")" + " / " + String(model.reservationRate) + "%"
        self.openDateLabel?.text = "개봉일: " + String(model.date)
    }
}
