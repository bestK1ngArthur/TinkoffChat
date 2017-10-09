//
//  MessageCell.swift
//  TinkoffChat
//
//  Created by Artem Belkov on 08/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

protocol MessageCellConfiguration: class {
    var messageText: String {get set}
}

class MessageCell: UITableViewCell, MessageCellConfiguration  {
    
    static let incomeIdentifier = "IncomeMessageCell"
    static let outcomeIdentifier = "OutcomeMessageCell"
    
    var messageText: String = ""
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        self.messageLabel.text = messageText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
