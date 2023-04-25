//
//  MovieFullImageVC.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/09/13.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

final class MovieFullImageViewController: UIViewController, StoryboardBased {
    static var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
    
    @IBOutlet private var fullScreen: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func configure(with image: UIImage) {
        self.fullScreen?.image = image
    }
    
    private func setupView() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapScreen(_:)))
        
        fullScreen?.isUserInteractionEnabled = true
        fullScreen?.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func tapScreen(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
