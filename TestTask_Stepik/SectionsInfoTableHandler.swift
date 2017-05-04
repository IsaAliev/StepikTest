//
//  SectionssInfoTableHandler.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class SectionsInfoTableHandler: InfoHandler {

    override init(course: Course) {
        super.init(course: course)
        self.rows = (course.sections?.count)!
    }
    
    override func cell(for tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! SectionTableViewCell
        if let section = course.detailedSections?[indexPath.row] {
        
            cell.titleLabel.text = "\(indexPath.row+1). " + section.title
        }
        
        return cell
    }
    
}
