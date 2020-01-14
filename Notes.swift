//
//  ViewController.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Notes: UIViewController {

    var containerView: UIView!
    var scrollView: UIScrollView!
    func notes() {
     
        /*********** NVActivityIndicatorView ***********/
        // Start
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), .none)
        // Stop
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
        
        /*********** Corner radius ***********/
        containerView.layer.cornerRadius = 40
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        /***********  ***********/
        
    }
    
    /*********** Scroll view ***********/
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
}

