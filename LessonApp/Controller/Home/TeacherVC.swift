//
//  HomeVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/14/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import AARatingBar
import Kingfisher
import Alamofire
import NVActivityIndicatorView

class TeacherVC: UIViewController {

    // MARK: - Variables
    var teacherData: Teacher?
    
    @IBOutlet weak var rightLayout: NSLayoutConstraint!
    @IBOutlet weak var swipeButtonsContainer: UIView!
    @IBOutlet weak var swipeButton: UIButton!
    @IBOutlet weak var showRatingLayout: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var notesLabel: UILabel!
    // MARK: - Rating outlets
    @IBOutlet weak var ratingTableView: UITableView!
    // teacher outlets
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var ratingView: AARatingBar!
    @IBOutlet weak var tNameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var certificateLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var teacherImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateContainerView()
        if teacherData != nil {
            updateTeacherInfo()
        }
    }
    
    // MARK: - Actions
    @IBAction func move(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            self.rightLayout.constant = sender.tag == 0 ? 0 : self.swipeButtonsContainer.frame.width * 0.4
            if self.rightLayout.constant > 0 {
                self.swipeButton.setTitle("التقييمات", for: .normal)
                self.showRatingLayout.constant = -1 * (self.containerView.frame.width - 30)
            } else {
                self.swipeButton.setTitle("الوصف", for: .normal)
                self.showRatingLayout.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func goToRegister(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToChatRoom(_ sender: UIButton) {
        let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "chatRoomVC") as! ChatRoomVC
        
        if let parameters = getCheckChatParameters() {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), .none)
            checkChatRequest(parameters: parameters) { (chatId) in
                if let chatId = chatId {
                    chatVC.chatId = chatId
                    chatVC.teacherData = self.teacherData
                }
                
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                self.present(chatVC, animated: true, completion: nil)
            }
        }
    }
    
    // get parameters
    private func getCheckChatParameters() -> [String : Any]? {
        guard let userId = getUserId(),
            let teacherId = teacherData?.id,
            let teacherName = teacherData?.name,
            let teacherImage = teacherData?.img
        else { return nil }
        let userName = getFullName()
        let parameters: [String : Any] = [
            "user_id" : userId,
            "user_name" : userName,
            "teacher_id" : teacherId,
            "teacher_name" : teacherName,
            "teacher_img" : teacherImage
        ]
        return parameters
    }
    
}

/****** Helper methods ******/
extension TeacherVC {
    // MARK: - Update container view corners
    func updateContainerView() {
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    // MARK: - get height of notes container view
    // change height of scroll view
    func getHeight(text: String?, width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        let height: CGFloat = label.frame.height
        label.removeFromSuperview()
        return height
    }
    // MARK: - update elements
    func updateTeacherInfo() {
        if let tInfo = teacherData {
            teacherNameLabel.text = tInfo.name ?? "الاسم"
            tNameLabel.text = tInfo.name ?? "الاسم"
            if let rate = NumberFormatter().number(from: tInfo.rate!) {
                ratingView.value = CGFloat(truncating: rate)
            }
            subjectLabel.text = tInfo.language ?? ""
            certificateLabel.text = tInfo.certification ?? ""
            favoriteLabel.text = tInfo.favorite ?? ""
            cityLabel.text = tInfo.city ?? ""
            scrollViewHeight.constant = scrollViewHeight.constant + getHeight(text: tInfo.notes, width: noteLabel.frame.size.width, font: noteLabel.font) - 20
            noteLabel.text = tInfo.notes ?? ""
            if let url = URL(string: KIMAGEURL + tInfo.img!) {
                teacherImageView.kf.setImage(with: url)
            }
        }
    }
}

/****** Collection view config ******/
extension TeacherVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCell", for: indexPath) as! SubjectCell
        return cell
    }
    
    // MARK: - adjust size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let itemWidth = (collectionView.frame.size.width - 20) / numberOfItemsPerRow
        return CGSize(width: itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

/****** Configure Rating table view ******/
extension TeacherVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RatingCell
        
        if indexPath.row == 2 {
            cell.studentNameLabel.text = "على"
            cell.studentOpenionLabel.text = "ايبسوم بالعربي عربي انجليزي لوريم  "
        } else {
            cell.studentNameLabel.text = "محمد"
            cell.studentOpenionLabel.text = "ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم   ايبسوم بالعربي عربي انجليزي لوريم  "
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
}

// MARK: - check chat request
extension TeacherVC {
    func checkChatRequest(parameters: [String : Any], completion: @escaping(_ chatId: String?) -> Void) {
        guard let url = URL(string: KCHEXKCHAT) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let _data = try JSONDecoder().decode([CheckChat].self, from: data)
                    return completion(_data[0].chatId)
                } catch {
                    self.alert(msg: error.localizedDescription)
                }
            case .failure(_):
                self.alert(msg: "لا يوجد اتصال بالانترنت")
            }
        }
    }
}
