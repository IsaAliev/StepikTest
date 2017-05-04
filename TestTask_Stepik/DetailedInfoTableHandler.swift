//
//  DetailedInfoTableHandler.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

private let propertiesList = [ "courseDescription" , "workload","certificate","targetAudience", "courseFormat", "requirements"]
private let labelsList = ["Описание" , "Нагрузка",  "Сертификат", "Целевая аудитория", "Формат Курса", "Требования"]

class DetailedInfoTableHandler: InfoHandler {

    var currentPropertiesList = [String]()
    var currentLabelsList = [String]()
    
    
    override init(course: Course) {
        let mirror = Mirror(reflecting: course)
        var count = 0

        for child in mirror.children {
            if let label = child.label {
                if propertiesList.contains(label){
                    if let val =  course.value(forKey: label) {
                        if !(val as! String).isEmpty {
                            count += 1
                            currentPropertiesList.append(label)
                            let idx = propertiesList.index(of: label)
                            currentLabelsList.append(labelsList[idx!])
                        }
                    }
                }
            }
        }
        
        currentLabelsList.sort { (str1, str2) -> Bool in
            return labelsList.index(of: str1)! < labelsList.index(of: str2)!
        }
        
        currentPropertiesList.sort { (str1, str2) -> Bool in
            return propertiesList.index(of: str1)! < propertiesList.index(of: str2)!
        }
        
        super.init(course: course)
        self.rows = count
    }
    
    override func cell(for tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DescriptionTableViewCell
        cell.titleLabel.text = currentLabelsList[indexPath.row]
        cell.descriptionLabel.text = course.value(forKey: currentPropertiesList[indexPath.row]) as? String
        
        return cell
    }
    
}
