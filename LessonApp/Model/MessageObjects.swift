//
//  Model.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/19/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation

struct Message {
    let userId: String
    let text: String
    let date: Date
}


struct CheckChat: Codable {
    let flag: Int?
    let chatId: String?
    
    enum CodingKeys: String, CodingKey {
        case flag
        case chatId = "chat_id"
    }
}


struct SendMessage: Codable {
    let success: Bool?
}


// MARK: - Message
struct ChatMessage: Codable {
    let senderID: Int?
    let senderName: String?
    let reciverID: Int?
    let reciverName, message: String?
    let chatID: Int?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case senderID = "sender_id"
        case senderName = "sender_name"
        case reciverID = "reciver_id"
        case reciverName = "reciver_name"
        case message
        case chatID = "chat_id"
        case date = "Date"
    }
}

typealias Messages = [ChatMessage]
