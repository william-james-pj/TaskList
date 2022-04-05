//
//  TaskModel.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import Foundation

class TaskModel: Codable {
    var title: String
    var description: String
    var dateString: String
    var subTasks: [SubTaskModel]
    
    init(){
        self.title = ""
        self.description = ""
        self.dateString = ""
        self.subTasks = []
    }
    
    init(title: String, description: String, dateString: String, subTasks: [SubTaskModel]){
        self.title = title
        self.description = description
        self.dateString = dateString
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
