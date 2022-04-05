//
//  HomeViewModel.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import Foundation

protocol HomeViewModelDelegate {
    func reloadCollection()
}

class HomeViewModel {
    fileprivate var taskList: [TaskModel] = []
    var delegate: HomeViewModelDelegate?
    
    func getTask() -> [TaskModel] {
        return taskList
    }
    
    func newTask(_ title: String, _ description: String) {
        let dateString = getDateString()
        
        let task = TaskModel(title: title, description: description, dateString: dateString, subTasks: [])
        taskList.append(task)
        
        delegate?.reloadCollection()
    }
    
    fileprivate func getDateString() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, d MMMM"
        return dateFormatter.string(from: now)
    }
}
