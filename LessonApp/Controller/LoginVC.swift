//
//  LoginVC.swift
//  LeasonTime
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - Variables
    var leftButton: UIButton!
    var rememberToggle: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfigration()
        
    }
    
    // MARK: - Actions
    @IBAction func login() {
        
    }
    
    @IBAction func rememberMe(_ sender: UIButton) {
        rememberToggle = !rememberToggle
        sender.setBackgroundImage(UIImage(named: rememberToggle ? "indicator active" : "indicator"), for: .normal)
    }
    
    @IBAction func forgetPassword() {
        
    }
    
    
}

