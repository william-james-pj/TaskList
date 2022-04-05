//
//  SeeTaskViewModel.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import Foundation

protocol SeeTaskViewModelDelegate {
    func reloadCollection()
}

class SeeTaskViewModel {
    fileprivate var task: TaskModel = TaskModel()
    var delegate: SeeTaskViewModelDelegate?
    
    func setTask(task: TaskModel) {
        self.task = task
    }
    
    func getTask() -> TaskModel {
        return task
    }
    
    func newSubTask(_ title: String) {
        let subTask = SubTaskModel(title: title, isComplet: false)
        task.subTasks.append(subTask)
        
        delegate?.reloadCollection()
    }
}
