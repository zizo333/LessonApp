//
//  CustomTF.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable var PlaceholderColor: UIColor {
        get { return self.PlaceholderColor }
        set { self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue])}
    }
}

