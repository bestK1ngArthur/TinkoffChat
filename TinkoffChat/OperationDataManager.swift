//
//  OperationDataManager.swift
//  TinkoffChat
//
//  Created by a.belkov on 16/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import Foundation

class OperationDataManager {

    static let shared = OperationDataManager()
    
    static let kUserName        = "kUserName"
    static let kUserDescription = "kUserDescription"
    static let kUserImageName   = "kUserImageName"
    
    var documentsDirectoryPath: URL {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(string: documentsDirectoryPathString)!
    }
    
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    
    func saveUser(_ user: User, success:(() -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        failure?(nil)
    }
    
    func loadUser(success:((User?) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        failure?(nil)
    }
}

class DataOperation: Operation {
    // Custom operation
}
