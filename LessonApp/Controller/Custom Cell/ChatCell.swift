//
//  ChatCell.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/19/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

enum MessageState: String {
    case incoming
    case outgoing
}

class ChatCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerMessageView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func genertateCell(message: ChatMessage, messageState: MessageState) {
        if messageState == .incoming {
            stackView.alignment = .leading
            containerMessageView.backgroundColor = #colorLiteral(red: 0.7763929963, green: 0.4258784652, blue: 0.128765732, alpha: 1)
            messageTextView.textAlignment = .left
        } else {
            stackView.alignment = .trailing
            containerMessageView.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            messageTextView.textAlignment = .right
        }
        messageTextView.text = message.message!
        dateLabel.text = message.date!
    }

}
