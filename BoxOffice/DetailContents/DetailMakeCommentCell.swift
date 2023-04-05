//
//  DetailMakeCommentCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/23.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

protocol DetailMakeCommentCellDelegate: AnyObject {
    func makeDetailComment(isSelected: Bool)
}

class DetailMakeCommentCell: UITableViewCell, Reusable {
    
    weak var delegate: DetailMakeCommentCellDelegate?
    
    @IBAction private func makeComment(_ sender: UIButton) {
        self.delegate?.makeDetailComment(isSelected: true)
    }
}
