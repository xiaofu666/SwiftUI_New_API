//
//  TaskModel.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/12.
//

import SwiftUI

struct TaskModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var isCompleted: Bool = false
}

class TaskDataModel {
    static let shared = TaskDataModel()
    var tasks: [TaskModel] = [
        .init(title: "Record Video"),
        .init(title: "Edit Video", isCompleted: true),
        .init(title: "Publish it"),
    ]
}
