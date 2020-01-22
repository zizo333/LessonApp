//
//  ChatRoomVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/19/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ChatRoomVC: UIViewController {

    
    // MARK: Outlets
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTableView: UITableView!
    
    // MARK: - Variables
    var messages: [Message] = []
    var teacherData: Teacher?
    var messageArray: Messages = []
    var chatId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeKeyboard()
        messageTextField.becomeFirstResponder()
        //chatTableView.transform = CGAffineTransform(rotationAngle: (-.pi))
        chatTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        chatTableView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllMessages()
    }

    // MARK: - Actions
    @IBAction func sendMessage() {
        guard let message = messageTextField.text , !message.isEmpty else { return }
//        let msg = Message(userId: userId, text: message, date: Date())
//        messages.insert(msg, at: 0)
//        updateTableView(msg: msg)
        if let parameters = getParameters(with: message) {
            sendRequest(parameters: parameters) { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.getAllMessages()
                }
            }
        }
        
    }
    @IBAction func dismissChatVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // get parameters
    private func getParameters(with message: String) -> [String : Any]? {
        guard let senderId = getUserId(),
            let receiverId = teacherData?.id,
            let receiverName = teacherData?.name
        else { return nil }
        let senderName = getFullName()
        let parameters: [String : Any] = [
            "sender_id" : senderId,
            "sender_name" : senderName,
            "reciver_id" : receiverId,
            "reciver_name" : receiverName,
            "message" : message,
            "chat_id" : chatId
        ]
        return parameters
    }
    
    private func getAllMessages() {
        allMessagesRequest { (messages) in
            if messages.count > 0 {
                self.messageArray = messages.reversed()
                self.chatTableView.reloadData()
            }
        }
    }
    
    // MARK: - Helper
    private func updateTableView(msg: Message) {
        let indexPath = IndexPath(row: 0, section: 0)
        chatTableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint.constant = keyboardViewEndFrame.height - 20
            self.view.layoutIfNeeded()
        }
    }
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint.constant = 16
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}

// MARK: - Configure table view
extension ChatRoomVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        let currentMsg = messageArray[indexPath.row]
        if currentMsg.senderID == Int(getUserId()!) {
            cell.genertateCell(message: currentMsg, messageState: .outgoing)
        } else {
            cell.genertateCell(message: currentMsg, messageState: .incoming)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

extension ChatRoomVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendMessage()
        return true
    }
}

// MARK: - message request
extension ChatRoomVC {
    
    // MARK: - Send request
    private func sendRequest(parameters: [String : Any], completion: @escaping(Bool) -> Void) {
        guard let url = URL(string: KSENDMESSAGE) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let _data = try JSONDecoder().decode(SendMessage.self, from: data)
                    return completion(_data.success!)
                } catch {
                    self.alert(msg: error.localizedDescription)
//                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                }
            case .failure(let error):
                self.alert(msg: error.localizedDescription)
//                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
            }
        }
    }
    
    // MARK: - Get all message
    private func allMessagesRequest(completion: @escaping(_ messages: Messages) -> Void) {
            guard let url = URL(string: KSEARCHMESSAGE) else { return }
        request(url, method: .post, parameters: ["chat_id" : chatId], encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let messages = try JSONDecoder().decode(Messages.self, from: data)
                        return completion(messages)
                    } catch {
                        self.alert(msg: error.localizedDescription)
    //                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                    }
                case .failure(let error):
                    self.alert(msg: error.localizedDescription)
    //                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
                }
            }
        }
    
}
