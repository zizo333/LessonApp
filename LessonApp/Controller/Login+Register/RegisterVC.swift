//
//  RegisterVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

protocol UserInfoDelegate {
    func setUserInfo(email: String, password: String)
}

class RegisterVC: LoginRegisterVC {
    
    // MARK: - Gender type
    enum Gender: String {
        case Male
        case Female
    }
    
    // MARK: - Variables
    var leftButtons: [UIButton] = []
    var leftConfirmPassButton: UIButton!
    var rememberToggle: Bool = false
    var gender: Gender?
    var selectedLabelFlag = false
    var delegate: UserInfoDelegate?

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfigration()
        
    }
    
    // MARK: - Actions
    @IBAction func approveAction(sender: UIButton) {
        rememberToggle = !rememberToggle
        sender.setBackgroundImage(UIImage(named: rememberToggle ? "indicator active" : "indicator"), for: .normal)
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        gender = sender.tag == 0 ? Gender.Male : Gender.Female
        if sender.tag == 0 {
            selectedGenderButton(genderBtn: maleBtn)
            unSelectedGenderButton(genderBtn: femaleBtn)
        } else if sender.tag == 1 {
            selectedGenderButton(genderBtn: femaleBtn)
            unSelectedGenderButton(genderBtn: maleBtn)
        }
    }
    
    @IBAction func selectDate() {
        DateOfBirth.instance.delegate = self
        DateOfBirth.instance.showDatePicker()
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register() {
        
        guard let parameters = checkFields() else {
            return
        }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), .none)
        registerRequest(parameters: parameters) { (flag) in
            if flag == 1 {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                self.delegate?.setUserInfo(email: parameters["email"] as! String, password: parameters["password"] as! String)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.alert(msg: "تأكد من ادخال البيانات")
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
            }
        }
    }
    
    /***** Helper methods *****/
    
    // MARK: - initial configuration
    func initialConfigration() {
        updateContainerView(containerView: self.containerView)
        leftButtons = [UIButton(), UIButton()]
        super.TFs = textFields
        super.lefBtns = leftButtons
        observeKeyboardState(scrollView: self.scrollView)
        updatePasswordTF(passwordTF: textFields[6], index: 0)
        updatePasswordTF(passwordTF: textFields[7], index: 1)
        addGesture(scrollViewContainer: self.scrollViewContainer)
    }
    
    func checkFields() -> [String : Any]? {
        var parameters: [String : Any] = [:]
        guard let firstName = textFields[0].text, !firstName.isEmpty,
            let secondName = textFields[1].text, !secondName.isEmpty,
            let email = textFields[2].text, !email.isEmpty,
            let country = textFields[3].text, !country.isEmpty,
            let nationality = textFields[4].text, !nationality.isEmpty,
            let phone = textFields[5].text, !phone.isEmpty,
            let pass = textFields[6].text, !pass.isEmpty,
            let confirmPass = textFields[7].text, !confirmPass.isEmpty,
            selectedLabelFlag, let _ = gender else {
                self.alert(msg: "تأكد من ادخال البيانات")
                return nil
        }
        guard pass == confirmPass else {
            self.alert(msg: "كلمة المرور غير متطابقة")
            return nil
        }
        parameters = [
            "first_name" : firstName,
            "secend_name" : secondName,
            "email" : email,
            "country" : country,
            "nationality" : nationality,
            "phone" : phone,
            "password" : pass,
            "birthdate" : dateLabel.text!,
            "gender" : "\(gender!)",
            "type" : 1,
            "balance" : 1
        ]
        return parameters
    }
    
    // MARK: - update gender buttons
    func selectedGenderButton(genderBtn: UIButton) {
        genderBtn.backgroundColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        genderBtn.layer.borderColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        genderBtn.setTitleColor(.white, for: .normal)
    }
    func unSelectedGenderButton(genderBtn: UIButton) {
        genderBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        genderBtn.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        genderBtn.setTitleColor(#colorLiteral(red: 0.1083643213, green: 0.09928876907, blue: 0.1019618139, alpha: 1), for: .normal)
    }
}

// MARK: - get selected date
extension RegisterVC: DatePickerDelegate {
    
    func getSelectedDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: date)
        dateLabel.textColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
        selectedLabelFlag = true
    }
    
}

/***** Configure return key *****/
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

/****** Register request ******/
extension RegisterVC {
    
    func registerRequest(parameters: [String : Any], completion: @escaping(_ flag: Int) -> Void) {
        guard let url = URL(string: KREGISTER) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let _data = try JSONDecoder().decode([RegisterData].self, from: data)
                    return completion(_data[0].flag!)
                } catch {
                    self.alert(msg: error.localizedDescription)
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                }
            case .failure(_):
                self.alert(msg: "لا يوجد اتصال بالانترنت")
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
            }
        }
    }
    
}
