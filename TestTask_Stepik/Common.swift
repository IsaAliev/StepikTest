//
//  Common.swift
//  TestTask_Stepik
//
//  Created by user on 28.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import Foundation
import UIKit
func selectionColor() -> UIColor {
    return UIColor(red: 79.0/255, green: 197.0/255, blue: 142.0/255, alpha: 0.1)
}

func mainColor() -> UIColor {
    return UIColor(red: 79.0/255, green: 197.0/255, blue: 142.0/255, alpha: 1.0)
}

func normalizeString(string: String) -> String {
    let str = string.replacingOccurrences(of: "</p>", with: "\n", options: .caseInsensitive, range: nil)
    return str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression,range: nil)
}
