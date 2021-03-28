//
//  TextFieldCondition.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation
import UIKit

class TextFieldCondition {
    var description: String
    var checker: (_ text: String) -> Bool
    
    init(description: String, checker: @escaping (_ text: String) -> Bool) {
        self.description = description
        self.checker = checker
    }
}
