//
//  LoginRegisterVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class LoginRegisterVC: UIViewController {

    
    // MARK: - Variables
    private var scrollView: UIScrollView!
    private var scrollViewContainer: UIView!
    var TFs: [UITextField] = []
    var lefBtns: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - update container view
    func updateContainerView(containerView: UIView) {
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - configure keyboard
    func observeKeyboardState(scrollView: UIScrollView) {
        self.scrollView = scrollView
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
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height - view.safeAreaInsets.bottom) + 10, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset

    }
    
    // MARK: - Add gestuer on scroll view container
    func addGesture(scrollViewContainer: UIView) {
        self.scrollViewContainer = scrollViewContainer
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollViewContainer.addGestureRecognizer(gesture)
    }
    
    @objc func hideKeyboard() {
        self.scrollViewContainer.endEditing(true)
    }

}

// MARK: - update password text fields
extension LoginRegisterVC {
    
    // MARK: - update password field
    func updatePasswordTF(passwordTF: UITextField, index: Int) {
        lefBtns[index].frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        lefBtns[index].setBackgroundImage(UIImage(named: "path"), for: .normal)
        lefBtns[index].tintColor = #colorLiteral(red: 0.1083643213, green: 0.09928876907, blue: 0.1019618139, alpha: 1)
        passwordTF.leftView = lefBtns[index]
        passwordTF.leftViewMode = UITextField.ViewMode.always
        
        lefBtns[index].addTarget(self, action: #selector(togglePassword(leftButton:)), for: .touchUpInside)
    }
    @objc func togglePassword(leftButton: UIButton) {
        let index = TFs.count > 1 ? lefBtns.firstIndex(of: leftButton)! + 6 : 0
        if TFs[index].isSecureTextEntry == true {
            TFs[index].isSecureTextEntry = false
            leftButton.tintColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        } else {
            TFs[index].isSecureTextEntry = true
            leftButton.tintColor = #colorLiteral(red: 0.1083643213, green: 0.09928876907, blue: 0.1019618139, alpha: 1)
        }

    }
    
}
