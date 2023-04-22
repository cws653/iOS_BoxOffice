//
//  DetailViewCommentCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class DetailCommentCell: UITableViewCell, Reusable {
    
    @IBOutlet private weak var writer: UILabel?
    @IBOutlet private weak var timestamp: UILabel?
    @IBOutlet private weak var contents: UITextView?
    @IBOutlet private weak var starView: Star?
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contents?.isScrollEnabled = false
        self.contents?.isEditable = false
    }

    internal func setUI(with comment: Comment) {
        let date = Date(timeIntervalSince1970: comment.timestamp)
        let strDate = self.dateFormatter.string(from: date)
        
        self.writer?.text = comment.writer
        self.timestamp?.text = "\(strDate)"
        self.contents?.text = comment.contents
        self.starView?.setupView(rateValue: Double(comment.rating))
    }
}
