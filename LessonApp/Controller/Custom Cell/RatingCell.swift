//
//  RatingCell.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/15/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class RatingCell: UITableViewCell {

    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentOpenionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
