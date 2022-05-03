//
//  TaskModel.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import Foundation

enum ETaskStatus: Codable {
    case toDo
    case progress
    case complete
}

enum ETaskPriority: Codable {
    case basic
    case important
    case urgent
}

class TaskModel: Codable {
    var id: String
    var title: String
    var description: String
    var dateString: String
    var status: ETaskStatus
    var priority: ETaskPriority
    var subTasks: [SubTaskModel]
    
    init(){
        self.id = ""
        self.title = ""
        self.description = ""
        self.dateString = ""
        self.status = .toDo
        self.priority = .basic
        self.subTasks = []
    }
    
    init(id: String, title: String, description: String, dateString: String, status: ETaskStatus, priority: ETaskPriority, subTasks: [SubTaskModel]){
        self.id = id
        self.title = title
        self.description = description
        self.dateString = dateString
        self.status = status
        self.priority = priority
        self.subTasks = subTasks
    }
}

class SubTaskModel: Codable {
    var title: String
    var isComplet: Bool
    
    init(){
        self.title = ""
        self.isComplet = false
    }
    
    init(title: String, isComplet: Bool){
        self.title = title
        self.isComplet = isComplet
    }
}
