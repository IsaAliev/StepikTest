//
//  InfoHandler.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class InfoHandler : NSObject {
    var rows = 0
    var course : Course
    
    init(course: Course) {
        self.course = course
    }
    
    func cell(for tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
