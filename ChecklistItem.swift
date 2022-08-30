//
//  ChecklistItem.swift
//  Todos
//
//  Created by Ammar Younas on 8/26/22.
//

import Foundation
import UIKit

// Class for Holding checklist items, text and status
class ChecklistItem: NSObject, Codable {
  var text = ""
  var checked = false
}
