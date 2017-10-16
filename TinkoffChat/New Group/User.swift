//
//  User.swift
//  TinkoffChat
//
//  Created by a.belkov on 16/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import Foundation

class User {
    
    let name: String
    let description: String
    let imageName: String // In future: URL
    
    init(name: String, description: String, imageName: String) {
        self.name = name
        self.description = description
        self.imageName = imageName
    }
}
