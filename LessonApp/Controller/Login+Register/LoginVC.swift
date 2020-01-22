//
//  LoginVC.swift
//  LeasonTime
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class LoginVC: LoginRegisterVC {

    // MARK: - Variables
    var leftButton: UIButton!
    var rememberToggle: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var rememberButton: UIButton!
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
        guard let email = emailTF.text, !email.isEmpty else {
            alert(msg: "أدخل البريد الالكترونى")
            return
        }
        guard let password = passwordTF.text, !password.isEmpty else {
            alert(msg: "أدخل كلمة المرور")
            return
        }
        let parameters: [String : Any] = ["email" : email , "password" : password, "token" : 0]
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), .none)
        loginRequest(parameters: parameters) { (data) in
             if data.success! {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                saveUserIdAndName(userId: data.id!, firstName: data.firstName!, lastName: data.secendName!)
                self.goToHome()
            } else {
                self.alert(msg: "تأكد من ادخال البيانات")
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
            }
        }
    }
    
    @IBAction func addNewAccount(_ sender: UIButton) {
        let registerVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "registerVC") as! RegisterVC
        registerVc.delegate = self
        present(registerVc, animated: true, completion: nil)
        
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

/****** login request ******/
extension LoginVC {
    
    func loginRequest(parameters: [String : Any], completion: @escaping(_ loginData: LoginData) -> Void) {
        guard let url = URL(string: KLOGIN) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let _data = try JSONDecoder().decode(LoginData.self, from: data)
                    return completion(_data)
                } catch {
                    self.alert(msg: error.localizedDescription)
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                }
            case .failure(let error):
                self.alert(msg: error.localizedDescription)
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
            }
        }
    }
    
}

// return data from register screen
extension LoginVC: UserInfoDelegate {
    func setUserInfo(email: String, password: String) {
        emailTF.text = email
        passwordTF.text = password
    }
    
    
}
