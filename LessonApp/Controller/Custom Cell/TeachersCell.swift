//
//  TeachersCell.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/16/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import AARatingBar
import Kingfisher

class TeachersCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //updateContainerView()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var teacherRatingView: AARatingBar!
    @IBOutlet weak var teacherNationalityLabel: UILabel!
    @IBOutlet weak var teacherSubjectLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func updateContainerView() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func generateCell(teacherData: Teacher) {
        teacherNameLabel.text = teacherData.name ?? "الاسم"
        let teacherRate = teacherData.rate!
        if let rate = NumberFormatter().number(from: teacherRate) {
            teacherRatingView.value = CGFloat(truncating: rate)
        }
        if let url = URL(string: KIMAGEURL + teacherData.img!) {
            teacherImage.kf.setImage(with: url)
        }
        teacherSubjectLabel.text = teacherData.language!
    }
    
}
