//
//  SeeTaskViewModel.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import Foundation
import RxSwift
import RxRelay

class SeeTaskViewModel {
    var subTaskBehavior: BehaviorRelay<TaskModel> = BehaviorRelay(value: TaskModel())
    var subTaskDeletePublish: PublishSubject<String> = PublishSubject()
    
    func newSubTask(_ subTask: SubTaskModel) {
        let taskAux = subTaskBehavior.value
        taskAux.subTasks.append(subTask)
        subTaskBehavior.accept(taskAux)
    }
    
    func updateSubTask(indexSubTask: Int, subTask: SubTaskModel) {
        let taskAux = subTaskBehavior.value
        taskAux.subTasks[indexSubTask] = subTask
        
        var numberIsActive = 0
        taskAux.subTasks.forEach { item in
            if item.isComplet  {
                numberIsActive += 1
            }
        }
        
        if taskAux.subTasks.count == numberIsActive {
            taskAux.status = .complete
        }
        
        subTaskBehavior.accept(taskAux)
    }
    
    func updateStatusTask() {
        let aux = subTaskBehavior.value
        switch aux.status {
        case .toDo:
            aux.status = .progress
        case .progress:
            aux.status = .complete
        case .complete:
            aux.status = .toDo
        }
        subTaskBehavior.accept(aux)
    }
    
    func updatePriorityTask() {
        let aux = subTaskBehavior.value
        switch aux.priority {
        case .basic:
            aux.priority = .important
        case .important:
            aux.priority = .urgent
        case .urgent:
            aux.priority = .basic
        }
        subTaskBehavior.accept(aux)
    }
    
    func deleteTask() {
        let aux = subTaskBehavior.value
        self.subTaskDeletePublish.onNext(aux.id)
    }
}
