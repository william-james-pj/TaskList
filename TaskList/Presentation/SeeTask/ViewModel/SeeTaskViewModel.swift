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
    
    func newSubTask(_ subTask: SubTaskModel) {
        let taskAux = subTaskBehavior.value
        taskAux.subTasks.append(subTask)
        subTaskBehavior.accept(taskAux)
    }
    
    func updateSubTask(indexSubTask: Int, subTask: SubTaskModel) {
        let taskAux = subTaskBehavior.value
        taskAux.subTasks[indexSubTask] = subTask
    }
    
    func updateStatusTask() {
        let aux = subTaskBehavior.value
        aux.status = aux.status == .toDo ? .progress : .toDo
        subTaskBehavior.accept(aux)
    }
}
