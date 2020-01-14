//
//  LoginVC.swift
//  LeasonTime
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class LoginVC: LoginRegisterVC {

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
    
    /***** Helper methods *****/
    
    // MARK: - initial configuration
    func initialConfigration() {
        updateContainerView(containerView: self.containerView)
        observeKeyboardState(scrollView: self.scrollView)
        leftButton = UIButton()
        super.TFs.append(passwordTF)
        super.lefBtns.append(leftButton)
        updatePasswordTF(passwordTF: passwordTF, index: 0)
        addGesture(scrollViewContainer: self.scrollViewContainer)
    }
}

/***** Configure return key *****/
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTF.isFirstResponder {
            passwordTF.becomeFirstResponder()
        } else {
            hideKeyboard()
        }
        return true
    }
}
