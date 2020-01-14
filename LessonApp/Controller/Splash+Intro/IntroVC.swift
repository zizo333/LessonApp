//
//  IntroVC.swift
//  LeasonTime
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class IntroVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet var pageControl: [UIView]!
    
    // MARK: - Variables
    let introData = IntroDataBank()
    var currentIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func skipAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if currentIndex < 3 {
            let indexPath = IndexPath(item: currentIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            updatePageControl()
            if currentIndex == 2 {
                sender.setTitle("الى التطبيق", for: .normal)
                skipButton.isHidden = true
            }
            currentIndex += 1
        }
    }
    
    func updatePageControl() {
        pageControl[currentIndex - 1].backgroundColor = .white
        pageControl[currentIndex - 1].layer.borderColor = #colorLiteral(red: 0.1083643213, green: 0.09928876907, blue: 0.1019618139, alpha: 1)
        
        pageControl[currentIndex].backgroundColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        pageControl[currentIndex].layer.borderColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        
    }
}

// MARK: - Configure Collection view
extension IntroVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        introData.introDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IntroCollectionViewCell
        cell.generateCell(data: introData.introDataArray[indexPath.item])
        
        return cell
    }
    
    // MARK: - adjust size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
