//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Artem Belkov on 08/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let messages = ["How ar u?", "Nice)", "Super, bro. So I bought a new iPhone X before the release😎", "WOW", "🤓", "!"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }

    // MARK: Table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = MessageCell()
        
        if indexPath.row % 2 == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.incomeIdentifier, for: indexPath) as! MessageCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.outcomeIdentifier, for: indexPath) as! MessageCell
        }
        cell.messageText = messages[indexPath.row]
        cell.configure()
        
        return cell
    }
}
