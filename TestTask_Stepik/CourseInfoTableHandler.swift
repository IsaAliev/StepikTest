//
//  CourseInfoTableHandler.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class CourseInfoTableHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    enum HandlerConfiguration {
        case common, detailed, sections
    }
    
    var configuration : HandlerConfiguration = .common {
        didSet {
            switch configuration {
            case .common:
                currentConfigurationObject = common
            case .detailed:
                currentConfigurationObject = detailed
            case .sections:
                currentConfigurationObject = modules
            }
        }
    }
    
    var currentConfigurationObject : InfoHandler!
    
    var course : Course
    
    var common : CommonInfoTableHandler
    var detailed : DetailedInfoTableHandler
    var modules : SectionsInfoTableHandler
    
    init(course: Course) {
        self.course = course
        common = CommonInfoTableHandler(course: course)
        detailed = DetailedInfoTableHandler(course: course)
        modules = SectionsInfoTableHandler(course: course)
        currentConfigurationObject = common

        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch configuration {
        case .common:
            return common.rows
        case .detailed:
            return detailed.rows
        case .sections:
            return (modules.rows)

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return currentConfigurationObject.cell(for: tableView, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
