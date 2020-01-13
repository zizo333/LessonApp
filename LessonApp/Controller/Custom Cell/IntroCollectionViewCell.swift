//
//  IntroCollectionViewCell.swift
//  LeasonTime
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var IntroImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    func generateCell(data: IntroData) {
        IntroImageView.image = UIImage(named: data.introImage)
        mainTitleLabel.text = data.introTitle
        detailsLabel.text = data.introDetails
    }
}
