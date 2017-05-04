//
//  UIButton+Border.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func addBorderWith(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
