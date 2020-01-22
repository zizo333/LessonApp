//
//  AllTeacher.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/17/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation

// MARK: - AllTeacherElement
struct Teacher: Codable {
    let id, name, city: String?
    let nationality, language, certification, favorite: String?
    let notes, hourPrice, languagePrice, rate: String?
    let img, dateReg: String?

    enum CodingKeys: String, CodingKey {
        case id, name, city, nationality, language, certification, favorite, notes
        case hourPrice = "hour_price"
        case languagePrice = "language_price"
        case rate, img
        case dateReg = "date_reg"
    }
}

typealias AllTeacher = [Teacher]
