//
//  GCDDataManager.swift
//  TinkoffChat
//
//  Created by a.belkov on 16/10/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

class GCDDataManager {

    static let shared = GCDDataManager()
    
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
        
        DispatchQueue.global().async {
            
            let userFilePath = self.documentsDirectoryPath.appendingPathComponent("user.json")
            
            // Creating a .json file in the Documents folder if needed
            if !self.fileManager.fileExists(atPath: userFilePath.absoluteString, isDirectory: &self.isDirectory) {
                let created = self.fileManager.createFile(atPath: userFilePath.absoluteString, contents: nil, attributes: nil)
                if created {
                    print("File created ")
                } else {
                    print("Couldn't create file for some reason")
                    failure?(nil)
                }
            } else {
                print("File already exists")
            }
            
            // Creating a dict of user data
            let userDict = [GCDDataManager.kUserName: user.name,
                            GCDDataManager.kUserDescription: user.description,
                            GCDDataManager.kUserImageName: user.imageName]
            
            // Creating JSON
            var jsonData: NSData!
            do {
                jsonData = try JSONSerialization.data(withJSONObject: userDict, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
                let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
                print(jsonString ?? "")
            } catch let error {
                print("Array to JSON conversion failed: \(error.localizedDescription)")
                failure?(error)
            }
            
            // Write that JSON to the file created earlier
            do {
                let file = try FileHandle(forWritingTo: userFilePath)
                file.write(jsonData as Data)
                print("JSON data was written to user file successfully!")
            } catch let error {
                print("Couldn't write to file: \(error.localizedDescription)")
                failure?(error)
            }
            
            success?()
        }
    }
    
    func loadUser(success:((User?) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        DispatchQueue.global().async {
        
            let userFilePath = self.documentsDirectoryPath.appendingPathComponent("user.json")
            
            // Read data from .json file and transform data into user
            do {
                let data = try Data(contentsOf: userFilePath, options: [])
                guard let userDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
                    failure?(nil)
                    return
                }
                print(userDict)
                
                let userName = userDict[GCDDataManager.kUserName] ?? ""
                let userDescription = userDict[GCDDataManager.kUserDescription] ?? ""
                let userImageName = userDict[GCDDataManager.kUserImageName] ?? ""
                
                let user = User(name: userName, description: userDescription, imageName: userImageName)
                success?(user)
                
            } catch let error {
                print(error)
                failure?(error)
            }
        }
    }
}
