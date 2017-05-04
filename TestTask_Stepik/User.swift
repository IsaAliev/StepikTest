//
//  User.swift
//  TestTask_Stepik
//
//  Created by user on 29.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import Foundation

struct User {
    var id : NSNumber
    var profile : NSNumber?
    var detail : String?
    var firstName : String?
    var lastName : String?
    var avatar : String?
    
    init(withResponse response: NSDictionary) {
        self.id = response["id"] as! NSNumber
        self.profile = response["profile"] as? NSNumber
        self.detail = response["detail"] as? String
        self.firstName = response["first_name"] as? String
        self.lastName = response["last_name"] as? String
        self.avatar = response["avatar"] as? String
    }
}
