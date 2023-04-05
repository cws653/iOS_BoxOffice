//
//  CustomTextView.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/04/05.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    func initialize() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.systemOrange.cgColor
        self.text = "내용을 입력해주세요."
        self.textColor = UIColor.systemGray4
        
        let startPosition = self.beginningOfDocument
        self.selectedTextRange = self.textRange(from: startPosition , to: startPosition )
    }
}
