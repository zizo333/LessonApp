//
//  LoginData.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/16/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation

// MARK: - AllTeacher
struct LoginData: Codable {
    let success: Bool?
    let id, firstName, secendName, email: String?
    let country, nationality, phoneCode, phone: String?
    let password, birthdate, gender, type: String?
    let balance, token, dateRegister: String?

    enum CodingKeys: String, CodingKey {
        case success, id
        case firstName = "first_name"
        case secendName = "secend_name"
        case email, country, nationality
        case phoneCode = "phone_code"
        case phone, password, birthdate, gender, type, balance, token
        case dateRegister = "date_register"
    }
}


struct RegisterData: Codable {
    let flag: Int?
}
