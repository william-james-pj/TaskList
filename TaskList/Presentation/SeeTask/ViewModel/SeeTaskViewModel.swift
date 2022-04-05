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

protocol SeeTaskViewModelDelegateSubTask {
    func updateSubTask(idTask: Int, subTasks: [SubTaskModel])
}

class SeeTaskViewModel {
    fileprivate var task: TaskModel = TaskModel()
    fileprivate var idTask: Int = -1
    var delegate: SeeTaskViewModelDelegate?
    var delegateSubTask: SeeTaskViewModelDelegateSubTask?
    
    func setTask(task: TaskModel, idTask: Int) {
        self.task = task
        self.idTask = idTask
    }
    
    func getTask() -> TaskModel {
        return task
    }
    
    func newSubTask(_ title: String) {
        let subTask = SubTaskModel(title: title, isComplet: false)
        task.subTasks.append(subTask)
        
        delegate?.reloadCollection()
        delegateSubTask?.updateSubTask(idTask: idTask, subTasks: task.subTasks)
    }
    
    func updateSubTask(idSubTask: Int, subTask: SubTaskModel) {
        self.task.subTasks[idSubTask] = subTask
        
        delegate?.reloadCollection()
        delegateSubTask?.updateSubTask(idTask: idTask, subTasks: task.subTasks)
    }
}
