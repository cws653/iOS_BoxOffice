//
//  DetailViewCastCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class DetailCastCell: UITableViewCell, Reusable {

    @IBOutlet private weak var directorLabel: UILabel?
    @IBOutlet private weak var actorLabel: UILabel?
    
    internal func setUI(with movie: DetailContents) {
        self.directorLabel?.text = movie.director
        self.actorLabel?.text = movie.actor
    }
}
