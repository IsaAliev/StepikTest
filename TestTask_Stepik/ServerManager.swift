//
//  ServerManager.swift
//  TestTask_Stepik
//
//  Created by user on 28.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import AFNetworking

class ServerManager: NSObject {
    static let shared = ServerManager()
    let manager = AFHTTPSessionManager(baseURL: URL(string: "https://stepik.org/api"))
    
    func getCoursesList(onPage page: Int, onSucces succes: @escaping ([Course]?, Bool)->(), onFailure failure: @escaping (Error)->() ) {


        
        let parameters = ["page": NSNumber(value: page),
                          "is_public": NSNumber(value: true),
                          "exclude_ended": NSNumber(value: true),
                          "order": "-activity" ] as [String : Any]
        
        manager.get("courses", parameters: parameters, progress: nil, success: { (task, data) in
            let hasNext = ((data as! NSDictionary)["meta"] as! NSDictionary)["has_next"] as! Int == 1

            let courses = DataFormer.formCoursesFrom(response: data)

            succes(courses, hasNext)
            
            }) { (task, error) in
                failure(error)
        }

    }
    
    func getUsersInfo(fromIDs ids: [NSNumber], onSucces succes: @escaping ([User])->(), onFailure failure: @escaping (Error)->() ) {

        var requestStr = "users?"
        
        for id in ids {
            let appendingString = "&ids[]=\(id.intValue)"
            requestStr.append(appendingString)
        }
        
        manager.get(requestStr, parameters: nil, progress: nil, success: { (task, data) in

            let users = DataFormer.formUsersFrom(response: data)
            succes(users)
            
        }) { (task, error) in
            failure(error)
        }
        
    }
    
    func getSectionsInfo(fromIDs ids: [NSNumber], onSucces succes: @escaping ([Section])->(), onFailure failure: @escaping (Error)->() ) {
        
        var requestStr = "sections?"
        
        for id in ids {
            let appendingString = "&ids[]=\(id.intValue)"
            requestStr.append(appendingString)
        }
        
        manager.get(requestStr, parameters: nil, progress: nil, success: { (task, data) in
            
            let sections = DataFormer.formSectionsFrom(response: data)
            succes(sections)
            
        }) { (task, error) in
            failure(error)
        }
        
    }
    
    

}
