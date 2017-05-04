//
//  Section.swift
//  TestTask_Stepik
//
//  Created by user on 03.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class Section: NSObject {
    var title : String
    
    init(withResponse response: NSDictionary) {
        self.title = response["title"] as! String
    }
    
}
