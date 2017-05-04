//
//  String+CaseConvertion.swift
//  TestTask_Stepik
//
//  Created by user on 28.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import Foundation

extension String {
    
    var underscoreToCamelCase: String {
        let items = self.components(separatedBy: "_")
        var camelCase = ""
        items.enumerated().forEach {
            camelCase += 0 == $0 ? $1 : $1.capitalized
        }
        return camelCase
    }
}
