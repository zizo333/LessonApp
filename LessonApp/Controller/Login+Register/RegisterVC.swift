//
//  RegisterVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

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
    var gender: Gender!

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


