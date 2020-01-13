//
//  CustomView.swift
//  LeasonTime
//
//  Created by Zizo Adel on 1/12/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var CornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue}
    }
    
    @IBInspectable var BorderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue}
    }
    
    @IBInspectable var BorderColor: UIColor {
        get { return UIColor(cgColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue.cgColor}
    }
}
