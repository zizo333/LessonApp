//
//  HomeVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/16/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchVew: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialUpdates()
    }

}


/****** Update views ******/
extension HomeVC {
    
    // MARK: - initial updates
    func initialUpdates() {
        updateContainerView()
        updateSearchView()
    }
    
    // MARK: - Update containerView top corners
    func updateContainerView() {
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    // MARK: - update search view
    func updateSearchView() {
        searchVew.layer.shadowColor = UIColor.black.cgColor
        searchVew.layer.shadowRadius = 2
        searchVew.layer.shadowOpacity = 0.3
        searchVew.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}

/****** Configure Collection view  data source ******/
extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TeachersCell
        return cell
    }
    
}
/****** Configure Collection view  delegate ******/
extension HomeVC: UICollectionViewDelegate {
    
    
}
/****** Configure Collection view  cell size ******/
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let itemWidth = (collectionView.frame.size.width - 15) / numberOfItemsPerRow
        return CGSize(width: itemWidth, height: 216)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}

