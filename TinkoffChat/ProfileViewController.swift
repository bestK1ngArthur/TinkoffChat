//
//  ViewController.swift
//  Tinkoff Chat
//
//  Created by Artem Belkov on 20/09/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        editButton.layer.borderColor = UIColor(displayP3Red: 51/255.0, green: 102/255.0, blue: 204/255.0, alpha: 1).cgColor
        editButton.layer.borderWidth = 2
        editButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logMethod()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logMethod()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logMethod()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logMethod()
    }

    // MARK: Helpers
    func logMethod(_ method: String = #function) {
        print("ProfileViewController: \(method)")
    }
    
    // MARK: Actions
    @IBAction func editAction(_ sender: Any) {
    }
    
}
