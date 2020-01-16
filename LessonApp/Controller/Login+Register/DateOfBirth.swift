//
//  DateOfBirth.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/14/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func getSelectedDate(date: Date)
}

class DateOfBirth: UIView {

    static let instance = DateOfBirth()
    
    // MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var parentView: UIView!
    
    // MARK: - Variables
    var delegate: DatePickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("DateOfBirth", owner: self, options: nil)
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    @IBAction func agreeAction() {
        let selectedDate = datePicker.date
        delegate?.getSelectedDate(date: selectedDate)
        parentView.removeFromSuperview()
    }
    
    func showDatePicker() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(parentView)
    }
    
}
