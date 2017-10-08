//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Arthur K1ng on 08/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private enum Section: Int{
        case online, history
        
        static var count: Int { return history.rawValue + 1 }
        static let titles = [online: "Online", history: "History"]
        
        func title() -> String {
            return Section.titles[self] ?? ""
        }
    }
    
    let onlineMessages = [(name: "Elon Mask", message: "Where ar u?", date: Date(timeIntervalSinceNow: -1), online: true, hasUnreadMessages: true),
                          (name: "Wozz", message: "Awful lines((", date: Date(timeIntervalSinceNow: -7), online: true, hasUnreadMessages: true),
                          (name: "Mark Z.", message: "I will call you back👌", date: Date(timeIntervalSinceNow: -10), online: true, hasUnreadMessages: true),
                          (name: "Nikolay Durov", message: "It is necessary to talk with my bro about this", date: Date(timeIntervalSinceNow: -100), online: true, hasUnreadMessages: false),
                          (name: "Tolstoy Tolstoy", message: "Check out my NSSpain presentation 😎", date: Date(timeIntervalSinceNow: -100), online: true, hasUnreadMessages: false),
                          (name: "Alex Zimin", message: "London😍😍", date: Date(timeIntervalSinceNow: -110), online: true, hasUnreadMessages: true),
                          (name: "@dickc", message: "Don't want to buy a bird?", date: Date(timeIntervalSinceNow: -3000), online: true, hasUnreadMessages: false),
                          (name: "Stefan Esser", message: "Help!!", date: Date(timeIntervalSinceNow: -3600), online: true, hasUnreadMessages: false),
                          (name: "Tim", message: "Sorry🙏", date: Date(timeIntervalSinceNow: -10000), online: true, hasUnreadMessages: true),
                          (name: "Biz Stone", message: "Nice)", date: Date(timeIntervalSinceNow: -100000), online: true, hasUnreadMessages: false)]
    
    let offlineMessages = [(name: "Alex", message: "Studied well 🤘", date: Date(timeIntervalSinceNow: -20), online: false, hasUnreadMessages: false),
                           (name: "Dimoon", message: "Dimooooon", date: Date(timeIntervalSinceNow: -20000), online: false, hasUnreadMessages: false),
                           (name: "Shoma", message: "May we go to Amsterdam?", date: Date(timeIntervalSinceNow: -20040), online: false, hasUnreadMessages: true),
                           (name: "Scott Forstall", message: "like to direct)", date: Date(timeIntervalSinceNow: -205000), online: false, hasUnreadMessages: false),
                           (name: "Sasha", message: "Something in Apple does not work very much", date: Date(timeIntervalSinceNow: -100000), online: false, hasUnreadMessages: false),
                           (name: "Stas Z.", message: "BRAAANCH", date: Date(timeIntervalSinceNow: -223000), online: false, hasUnreadMessages: false),
                           (name: "Alisa Volozh", message: "How ar u?)", date: Date(timeIntervalSinceNow: -230000), online: false, hasUnreadMessages: false),
                           (name: "Jony", message: "😈", date: Date(timeIntervalSinceNow: -200600), online: false, hasUnreadMessages: true),
                           (name: "Stephen Daniels", message: "We urgently need your answer!", date: Date(timeIntervalSinceNow: -223500), online: false, hasUnreadMessages: false),
                           (name: "Steve Jobs", message: "😔", date: Date(timeIntervalSinceNow: -22300055), online: false, hasUnreadMessages: false)]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Tinkoff Chat"
        self.tableView.sectionHeaderHeight = 44
    }

    // MARK: Table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = Section(rawValue: section)
        return section?.title()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section = Section(rawValue: section)
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: ConversationHeader.identifier) as! ConversationHeader
        headerCell.titleLabel.text = section?.title()
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.identifier, for: indexPath) as! ConversationCell
        
        let section = Section(rawValue: indexPath.section)!
        switch section {
        case .online:
            cell.name = onlineMessages[indexPath.row].name
            cell.message = onlineMessages[indexPath.row].message
            cell.date = onlineMessages[indexPath.row].date
            cell.online = onlineMessages[indexPath.row].online
            cell.hasUnreadMessages = onlineMessages[indexPath.row].hasUnreadMessages
            break
        case .history:
            cell.name = offlineMessages[indexPath.row].name
            cell.message = offlineMessages[indexPath.row].message
            cell.date = offlineMessages[indexPath.row].date
            cell.online = offlineMessages[indexPath.row].online
            cell.hasUnreadMessages = offlineMessages[indexPath.row].hasUnreadMessages
            break
        }

        cell.configure()
        return cell
    }
    
}
