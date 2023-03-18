//
//  DetailViewContentsCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/09/12.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class DetailContentsCell: UITableViewCell, Reusable {

<<<<<<< main:BoxOffice/DetailContents/DetailContentsCell.swift
    @IBOutlet private weak var content: UITextView?

    internal func setUI(with model: DetailContents) {
=======
    @IBOutlet weak var content: UITextView?

    internal func setUI(with model: DetailContents) {
        
>>>>>>> refactor: IB 객체들 옵셔널 처리:BoxOffice/DetailContents/DetailViewContentsCell.swift
        self.content?.text = model.synopsis
        self.content?.isScrollEnabled = false
        self.content?.isEditable = false
    }
}
