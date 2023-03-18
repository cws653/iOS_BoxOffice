//
//  MakeCommentsVC.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/09/13.
//  Copyright © 2020 최원석. All rights reserved.
//

import UIKit

protocol MakeCommentsViewDelegate: AnyObject {
    func makeComment()
}

final class MakeCommentsViewController: UIViewController, StoryboardBased {
    static var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
    
    weak var delegate: MakeCommentsViewDelegate?
    var movies: Movies?
<<<<<<< main
    private let userInfo = UserDefaults.standard
    private var finishButton: UIBarButtonItem {
        let finishButton = UIBarButtonItem.init(title: "완료", style: UIBarButtonItem.Style.plain, target: self, action: #selector(makeComments(sender:)))
        return finishButton
    }
    private var backButton: UIBarButtonItem {
        let backButton = UIBarButtonItem.init(title: "취소", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        return backButton
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var gradeImage: UIImageView?
    @IBOutlet private weak var contentsTextView: UITextView?
    @IBOutlet private weak var gradeLabel: UILabel?
    @IBOutlet private weak var gradeSlider: UISlider?
    @IBOutlet private weak var userIdTextField: UITextField?
    @IBOutlet private weak var starView: Star?
    
=======

    @IBOutlet weak var labelOfTitle: UILabel?
    @IBOutlet weak var imageOfGrade: UIImageView?
    @IBOutlet weak var contentsTextView: UITextView?
    @IBOutlet weak var gradeOfLabel: UILabel?
    @IBOutlet weak var sliderOfGrade: UISlider?
    @IBOutlet weak var userIdTextField: UITextField?

    @IBOutlet weak var firstStar: UIImageView?
    @IBOutlet weak var secondStar: UIImageView?
    @IBOutlet weak var thirdStar: UIImageView?
    @IBOutlet weak var fourthStar: UIImageView?
    @IBOutlet weak var fifthStar: UIImageView?

>>>>>>> refactor: IB 객체들 옵셔널 처리
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< main
        setupView()
    }
    
    func setupView() {
        self.title = "한줄평 작성"
        self.navigationItem.rightBarButtonItem = self.finishButton
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = self.backButton
=======
        let backButton = UIBarButtonItem.init(title: "취소", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        self.contentsTextView?.layer.borderWidth = 2.0
        self.contentsTextView?.layer.borderColor = UIColor.systemOrange.cgColor
        self.contentsTextView?.text = "내용을 입력해주세요."
        self.contentsTextView?.textColor = UIColor.systemGray4
        
        let startPosition = contentsTextView?.beginningOfDocument
        contentsTextView?.selectedTextRange = contentsTextView?.textRange(from: startPosition ?? UITextPosition(), to: startPosition ?? UITextPosition())
>>>>>>> refactor: IB 객체들 옵셔널 처리
        
        guard let movie = self.movies else { return }
        self.titleLabel?.text = movie.title
        self.gradeImage?.image = Grade(rawValue: movie.grade)?.image
        self.gradeSlider?.value = Float(movie.userRating)
        self.gradeLabel?.text = String(round(movie.userRating))
        self.starView?.setupView(rateValue: movie.userRating)
        
        let userId = self.userInfo.string(forKey: "userId")
        self.userIdTextField?.text = userId
    }
    
    @objc func makeComments(sender: UIBarButtonItem) {
        if self.isValidCheckButton() {
            self.userInfo.set(userIdTextField?.text, forKey: "userId")
            
            guard let writer = self.userIdTextField?.text else { return }
<<<<<<< main
            guard let movieId = self.movies?.id else { return }
            guard let contents = self.contentsTextView?.text else { return }
            let rating = Int(round(self.gradeSlider?.value ?? 0))
            
            let postCommentData = PostComment(rating: rating, writer: writer, movie_id: movieId, contents: contents)
            MovieServiceProvider.shared.postComment(postComment: postCommentData) {
=======
            guard let movie_id = self.movies?.id else { return }
            guard let contents = self.contentsTextView?.text else { return }

            let postCommentData = PostComment(rating: rating, writer: writer, movie_id: movie_id, contents: contents)
            movieServiceProvider.postComment(postComment: postCommentData) {
>>>>>>> refactor: IB 객체들 옵셔널 처리
                DispatchQueue.main.async {
                    self.delegate?.makeComment()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            let alertController = UIAlertController(title: "경고", message: "내용을 입력해주세요.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        }
    }
    
    private func isValidCheckButton() -> Bool {
        guard
            let userRate = gradeSlider?.value,
            let userId = userIdTextField?.text, !userId.isEmpty,
            let contents = contentsTextView?.text, !contents.isEmpty
        else {
            return false
        }
        return true
    }
    
    @IBAction private func changeSlideValue(_ sender: UISlider) {
        let rateValue = sender.value
        self.starView?.setupView(rateValue: Double(rateValue))
        self.gradeLabel?.text = String(Int(round(rateValue)))
        if sender.isTracking { return }
    }
}

// MARK: - UITableViewDelegate
extension MakeCommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 5
        } else {
            return 0
        }
    }
}

// MARK: - UITextViewDelegate
extension MakeCommentsViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
<<<<<<< main
        if self.contentsTextView?.textColor == UIColor.systemGray4 {
            let startPosition = self.contentsTextView?.beginningOfDocument
            self.contentsTextView?.selectedTextRange = self.contentsTextView?.textRange(from: startPosition ?? UITextPosition(), to: startPosition ?? UITextPosition())
=======
        if contentsTextView?.textColor == UIColor.systemGray4 {
            let startPosition = contentsTextView?.beginningOfDocument
            contentsTextView?.selectedTextRange = contentsTextView?.textRange(from: startPosition ?? UITextPosition(), to: startPosition ?? UITextPosition())
>>>>>>> refactor: IB 객체들 옵셔널 처리
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentsTextView?.text.isEmpty != nil {
            contentsTextView?.text = "내용 입력하세요."
            contentsTextView?.textColor = UIColor.systemGray4
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if contentsTextView?.textColor == UIColor.systemGray4 {
            contentsTextView?.text = nil
            contentsTextView?.textColor = UIColor.black
        }
    }
}

