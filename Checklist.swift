//
//  Checklist.swift
//  Todos
//
//  Created by Ammar Younas on 8/30/22.
//

import UIKit
class Checklist: NSObject,Codable
{
    var name = ""
    var items = [ChecklistItem]()
    init(name: String) {
      self.name = name
      super.init()
    }
    
}
