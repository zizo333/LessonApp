//
//  LogOutVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/19/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class LogOutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOut() {
        removeCurrentUser()
        dismiss(animated: true, completion: nil)
    }
}
