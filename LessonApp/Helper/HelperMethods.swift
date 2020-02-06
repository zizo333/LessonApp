//
//  HelperMethods.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

let def = UserDefaults.standard
extension UIViewController {
        
    func alert(msg:String) {
        let alert = UIAlertController(title: " ", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "حسنا", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToHome() {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homeVC") as! HomeVC
        self.present(homeVC, animated: true, completion: nil)
    }
    
}

// MARK: - save the user
func saveUserIdAndName(userId: String, firstName: String, lastName: String) {
    def.set(userId, forKey: KUSERID)
    def.set(firstName, forKey: KFIRSTNAME)
    def.set(lastName, forKey: KLASTNAME)
}

// MARK: - remove the user
func removeCurrentUser() {
    def.removeObject(forKey: KUSERID)
    def.removeObject(forKey: KFIRSTNAME)
    def.removeObject(forKey: KLASTNAME)
}
// MARK: - get user id
func getUserId() -> String? {
    return def.string(forKey: KUSERID)
}
func getFirstName() -> String? {
    return def.string(forKey: KFIRSTNAME)
}
func getLastName() -> String? {
    return def.string(forKey: KLASTNAME)
}

func getFullName() -> String {
    if let firstName = getFirstName(), let lastName = getLastName() {
        return "\(firstName) \(lastName)"
    } else {
        return ""
    }
}

// MARK: - configure intro screen
func saveIntroAtFirstTime(introDidAppear: Bool) {
    def.set(introDidAppear, forKey: KINTRO)
}
func checkIntroDidAppear() -> Bool {
    return def.bool(forKey: KINTRO)
}

// MARK: - save chat flag
func saveChatId(chatId: String, teacherId: String) {
    def.set([teacherId : chatId], forKey: KCHATID)
}
func getChatId(teacherId: String) -> String? {
    if let chatId = def.dictionary(forKey: KCHATID) {
        return chatId[teacherId] as? String
    } else {
        return nil
    }
}
