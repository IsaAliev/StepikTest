//
//  CommonInfoTableHandler.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class CommonInfoTableHandler: InfoHandler {

    override init(course: Course) {
        super.init(course: course)
        self.rows = 2
    }
    
    override func cell(for tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DescriptionTableViewCell
            
            cell.titleLabel.text = "О курсе"
            cell.descriptionLabel.text = course.summary
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructorsCell", for: indexPath) as! InstructorsTableViewCell
            cell.course = course
            cell.collectionView.reloadData()
            
            return cell
            
        }

    }
    
}
