//
//  ConversationCell.swift
//  TinkoffChat
//
//  Created by Arthur K1ng on 08/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

protocol ConversationCellConfiguration: class {
    
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessages: Bool {get set}
}

class ConversationCell: UITableViewCell, ConversationCellConfiguration {
    
    static let identifier = "ConversationCell"
    
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool = false
    var hasUnreadMessages: Bool = false

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        
        // Configure name label
        nameLabel.text = name
        
        // Configure message label
        if let message = message {
            // Show message with black text
            nameLabel.textColor = UIColor.black
            messageLabel.text = message
        } else {
            // Show notification with gray text
            nameLabel.textColor = UIColor.darkGray
            messageLabel.text = "No messages yet"
        }
        
        // Configure date label
        if let date = date {
            dateLabel.text = stringFromDate(date) ?? ""
        }
        
        // Configure online state
        if online {
            contentView.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 0.75, alpha: 1.0)
        } else {
            contentView.backgroundColor = UIColor.white
        }
        
        // Configure hasUnreadMessages state
        if hasUnreadMessages {
            messageLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        } else {
            messageLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Date
    
    private static let timeFormat = "HH:mm"
    private static let dateFormat = "dd MMM"
    
    private func stringFromDate(_ date: Date) -> String? {
        
        let formatter = DateFormatter()
        
        // Set today date
        formatter.dateFormat = "dd.MM.yyyy"
        let today = formatter.date(from: formatter.string(from: Date()))! // Hack to get start today date

        if date < today {
            // If yesterday or earlier
            formatter.dateFormat = ConversationCell.dateFormat
        } else {
            // If today
            formatter.dateFormat = ConversationCell.timeFormat
        }
        
        return formatter.string(from: date)
    }
}
