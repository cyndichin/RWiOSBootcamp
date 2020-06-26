//
//  ChecklistItem.swift
//  Checklist
//
//  Created by cynber on 6/23/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    @objc var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
