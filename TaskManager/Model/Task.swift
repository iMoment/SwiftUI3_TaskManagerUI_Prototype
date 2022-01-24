//
//  Task.swift
//  TaskManager
//
//  Created by Stanley Pan on 2022/01/24.
//

import SwiftUI

// MARK: Task Model
struct Task: Identifiable {
    var id: String = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
