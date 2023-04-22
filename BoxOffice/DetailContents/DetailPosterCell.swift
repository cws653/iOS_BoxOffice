//
//  DetailViewPosterCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

protocol DetailPosterCellDelegate: AnyObject {
    func makeFullImage(isSelected: Bool, image: UIImage)
}

class DetailPosterCell: UITableViewCell, Reusable {
    
    @IBOutlet private weak var movieImageView: UIImageView?
    @IBOutlet private weak var movieTitleLabel: UILabel?
    @IBOutlet private weak var openDayLabel: UILabel?
    @IBOutlet private weak var genreAndDurationLabel: UILabel?
    @IBOutlet private weak var reservationRateLabel: UILabel?
    @IBOutlet private weak var userRatingLabel: UILabel?
    @IBOutlet private weak var audienceCountLabel: UILabel?
    @IBOutlet private weak var gradeImageView: UIImageView?
    @IBOutlet private weak var starsView: Star!
    
    weak var delegate: DetailPosterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage(tapGestureRecognizer:)))
        self.movieImageView?.isUserInteractionEnabled = true
        self.movieImageView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupUI(model: DetailContents, imageData: Data) {
        self.movieImageView?.image = UIImage(data: imageData)
        self.movieTitleLabel?.text = model.title
        self.openDayLabel?.text = model.date
        self.genreAndDurationLabel?.text = model.genre + "/" + String(model.duration)
        self.reservationRateLabel?.text = "\(model.reservationRate)"
        self.userRatingLabel?.text = "\(model.userRating)"
        self.audienceCountLabel?.text = "\(model.audience)"
        self.gradeImageView?.image = Grade(rawValue: model.grade)?.image
        self.starsView.setupView(rateValue: model.userRating)
    }
    
    @objc func tapImage(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let tappedImage = tapGestureRecognizer.view as? UIImageView else { return }
        self.delegate?.makeFullImage(isSelected: true, image: tappedImage.image ?? UIImage())
    }
}
