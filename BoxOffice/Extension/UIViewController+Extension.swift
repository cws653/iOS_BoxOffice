//
//  UIViewController+Extension.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/20.
//  Copyright © 2023 최원석. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertController(title: String, message: String, sortActionHandler: ((MovieSortMode) -> Void)? = nil, cancelActionTitle: String = "취소", cancelActionHandler: (() -> Void)? = nil) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let sortActionByReservationRate: UIAlertAction = UIAlertAction(title: MovieSortMode.reservationRate.title, style: .default) { _ in
            if let sortActionHandler = sortActionHandler {
                sortActionHandler(MovieSortMode.reservationRate)
            }
        }
        alertController.addAction(sortActionByReservationRate)
        
        let sortActionByQuration: UIAlertAction = UIAlertAction(title: MovieSortMode.quration.title, style: .default) { _ in
            if let sortActionHandler = sortActionHandler {
                sortActionHandler(MovieSortMode.quration)
            }
        }
        alertController.addAction(sortActionByQuration)
        
        let sortActionByOpen: UIAlertAction = UIAlertAction(title: MovieSortMode.open.title, style: .default) { _ in
            if let sortActionHandler = sortActionHandler {
                sortActionHandler(MovieSortMode.open)
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
