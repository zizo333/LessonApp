//
//  Login.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

/*** Configure return key ***/
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

/*** Helper ***/
extension LoginVC {
    
    // MARK: - initial configuration
    func initialConfigration() {
        updateContainerView()
        observeKeyboardState()
        updatePasswordTF()
        addGesture()
    }
    
    // MARK: - update container view
    func updateContainerView() {
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - update password field
    func updatePasswordTF() {
        leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        leftButton.setBackgroundImage(UIImage(named: "path"), for: .normal)
        leftButton.tintColor = #colorLiteral(red: 0.1083643213, green: 0.09928876907, blue: 0.1019618139, alpha: 1)
        passwordTF.leftView = leftButton
        passwordTF.leftViewMode = UITextField.ViewMode.always
        
        leftButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
    }
    @objc func togglePassword() {
        if passwordTF.isSecureTextEntry == true {
            passwordTF.isSecureTextEntry = false
            leftButton.tintColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        } else {
            passwordTF.isSecureTextEntry = true
            leftButton.tintColor = #colorLiteral(red: 0.1083643213, green: 0.09928876907, blue: 0.1019618139, alpha: 1)
        }
            
    }
    
    // MARK: - configure keyboard
    func observeKeyboardState() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset

    }
    
    
    
    // MARK: - Add gestuer on scroll view container
    func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollViewContainer.addGestureRecognizer(gesture)
    }
    
    @objc func hideKeyboard() {
        self.scrollViewContainer.endEditing(true)
    }
    
}

