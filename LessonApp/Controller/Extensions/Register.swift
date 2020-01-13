//
//  Register.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

/*** Configure return key ***/
extension RegisterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextIndex = textField.tag + 1
        if nextIndex != textFields.count {
            textFields[nextIndex].becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
}

/*** Helper ***/
extension RegisterVC {
    
    // MARK: - initial configuration
    func initialConfigration() {
        updateContainerView()
        leftButtons = [UIButton(), UIButton()]
//        observeKeyboardState()
        updatePasswordTF(passwordTF: textFields[6], index: 0)
        updatePasswordTF(passwordTF: textFields[7], index: 1)
//        addGesture()
    }
    
    // MARK: - update container view
    func updateContainerView() {
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - update password field
    func updatePasswordTF(passwordTF: UITextField, index: Int) {
        leftButtons[index].frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        leftButtons[index].setBackgroundImage(UIImage(named: "path"), for: .normal)
        leftButtons[index].tintColor = #colorLiteral(red: 0.1083643213, green: 0.09928876907, blue: 0.1019618139, alpha: 1)
        passwordTF.leftView = leftButtons[index]
        passwordTF.leftViewMode = UITextField.ViewMode.always
        
        leftButtons[index].addTarget(self, action: #selector(togglePassword(leftButton:)), for: .touchUpInside)
    }
    @objc func togglePassword(leftButton: UIButton) {
        let index = leftButtons.firstIndex(of: leftButton)! + 6
        if textFields[index].isSecureTextEntry == true {
            textFields[index].isSecureTextEntry = false
            leftButton.tintColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        } else {
            textFields[index].isSecureTextEntry = true
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
        //scrollViewContainer.addGestureRecognizer(gesture)
    }
    
    @objc func hideKeyboard() {
        //self.scrollViewContainer.endEditing(true)
    }
    
}

