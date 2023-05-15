//
//  UIViewController+Extension.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/20.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertController(title: String, message: String, sortActionHandler: ((MovieSortType) -> Void)? = nil, cancelActionTitle: String = "취소", cancelActionHandler: (() -> Void)? = nil) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let sortActionByReservationRate: UIAlertAction = UIAlertAction(title: MovieSortType.reservationRate.title, style: .default) { _ in
            if let sortActionHandler = sortActionHandler {
                sortActionHandler(MovieSortType.reservationRate)
            }
        }
        alertController.addAction(sortActionByReservationRate)
        
        let sortActionByQuration: UIAlertAction = UIAlertAction(title: MovieSortType.quration.title, style: .default) { _ in
            if let sortActionHandler = sortActionHandler {
                sortActionHandler(MovieSortType.quration)
            }
        }
        alertController.addAction(sortActionByQuration)
        
        let sortActionByOpen: UIAlertAction = UIAlertAction(title: MovieSortType.open.title, style: .default) { _ in
            if let sortActionHandler = sortActionHandler {
                sortActionHandler(MovieSortType.open)
            }
        }
        alertController.addAction(sortActionByOpen)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelActionTitle, style: .default) { _ in
            if let cancelActionHandler = cancelActionHandler {
                cancelActionHandler()
            }
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
