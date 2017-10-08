//
//  ConversationHeader.swift
//  TinkoffChat
//
//  Created by Arthur K1ng on 08/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

class ConversationHeader: UITableViewCell {

    static let identifier = "ConversationHeader"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
