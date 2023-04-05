//
//  BoxOffice
//  DetailViewContentsCell.swift
//
//  Created by 최원석 on 2020/09/12.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class DetailContentsCell: UITableViewCell, Reusable {

    @IBOutlet private weak var content: UITextView?

    internal func setUI(with model: DetailContents) {
        self.content?.text = model.synopsis
        self.content?.isScrollEnabled = false
        self.content?.isEditable = false
    }
}
