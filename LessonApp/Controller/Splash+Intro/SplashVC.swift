//
//  SplashVC.swift
//  LeasonTime
//
//  Created by Zizo Adel on 1/12/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SplashVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var containerStackView: UIStackView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSplashScreen()
        
    }
    
    // MARK: - Run splash screen
    func configureSplashScreen() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), .none)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (timer) in
            UIView.animate(withDuration: 1) {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                self.containerStackView.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }

}
