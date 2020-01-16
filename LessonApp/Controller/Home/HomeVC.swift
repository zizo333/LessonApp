//
//  HomeVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/14/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var rightLayout: NSLayoutConstraint!
    @IBOutlet weak var swipeButtonsContainer: UIView!
    @IBOutlet weak var swipeButton: UIButton!
    @IBOutlet weak var showRatingLayout: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    // MARK: - Rating outlets
    @IBOutlet weak var ratingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateContainerView()
        ratingTableView.estimatedRowHeight = UITableView.automaticDimension
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
extension HomeVC {
    // MARK: - Update container view corners
    func updateContainerView() {
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

/****** Collection view config ******/
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.row == 2 {
            cell.textLabel?.text = "Ali"
            cell.detailTextLabel?.text = "A label can contain an arbitrary amount of text, but UILabel may shrink, wrap, or truncate the text"
        } else {
            cell.textLabel?.text = "Zizo"
            cell.detailTextLabel?.text = "A label can contain an arbitrary amount of text, but UILabel may shrink, wrap, or truncate the text, depending on the size of the bounding rectangle and properties you set. You can control the font, text color, alignment, highlighting, and shadowing of the text in the label."
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
