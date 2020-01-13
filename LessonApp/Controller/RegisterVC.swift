//
//  RegisterVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    // MARK: - Variables
    var leftButtons: [UIButton] = []
    var leftConfirmPassButton: UIButton!
    var rememberToggle: Bool = false

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfigration()        
    }
    
    // MARK: - Actions
    @IBAction func approveAction() {
        
    }
    
    @IBAction func register() {
        
    }
    
}


