//
//  DetailViewCastCell.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/09/19.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

class DetailCastCell: UITableViewCell, Reusable {

<<<<<<< main:BoxOffice/DetailContents/DetailCastCell.swift
    @IBOutlet private weak var directorLabel: UILabel?
    @IBOutlet private weak var actorLabel: UILabel?
    
    internal func setUI(with movie: DetailContents) {
=======
    @IBOutlet weak var directorLabel: UILabel?
    @IBOutlet weak var actorLabel: UILabel?
    
    internal func setUI(with movie: DetailContents) {
        
>>>>>>> refactor: IB 객체들 옵셔널 처리:BoxOffice/DetailContents/DetailViewCastCell.swift
        self.directorLabel?.text = movie.director
        self.actorLabel?.text = movie.actor
    }
}
