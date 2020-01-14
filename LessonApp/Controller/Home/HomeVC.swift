//
//  HomeVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/14/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var layout: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func move(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            self.layout.constant = sender.tag == 0 ? 0 : 100
            self.view.layoutIfNeeded()
        }
    }
    
    

}
