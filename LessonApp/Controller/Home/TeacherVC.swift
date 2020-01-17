//
//  HomeVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/14/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class TeacherVC: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateContainerView()
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
