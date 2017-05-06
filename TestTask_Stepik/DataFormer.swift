//
//  DataFormer.swift
//  TestTask_Stepik
//
//  Created by user on 28.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class DataFormer: NSObject {

    class func formCoursesFrom(response: Any?) -> [Course] {
        
        var result = [Course]()
        
        let courses = (response as! NSDictionary)["courses"] as! NSArray

        for course in courses {
            result.append(Course(withResponse:  course as! NSDictionary))
        }


        return result
    }
    
    
    class func formUsersFrom(response: Any?) -> [User] {
        
        var result = [User]()
        
        let users = (response as! NSDictionary)["users"] as! NSArray
        
        for user in users {
            result.append(User(withResponse:  user as! NSDictionary))
        }
        
        
        return result
    }
    
    class func formSectionsFrom(response: Any?) -> [Section] {
        
        var result = [Section]()
        
        let sections = (response as! NSDictionary)["sections"] as! NSArray
        
        for section in sections {
            result.append(Section(withResponse:  section as! NSDictionary))
        }
        
        return result
    }
    
}
