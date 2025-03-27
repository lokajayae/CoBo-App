//
//  User.swift
//  CoBo
//
//  Created by Evan Lokajaya on 25/03/25.
//

import Foundation
import SwiftData

@Model
class User: DropdownProtocol {
    var name: String
    var email: String
    
    var dropdownLabel: String {
        get {
            return self.name
        }
    }
    
    var value: Any {
        get {
            return self
        }
    }
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
