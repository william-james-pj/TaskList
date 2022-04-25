//
//  HomeViewModel.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
    let disposeBag = DisposeBag()
    var taskBehavior: BehaviorRelay<[TaskModel]> = BehaviorRelay(value: [])
    
    init() {
        getData()
    }
    
    func newTask(_ task: TaskModel) {
        var aux = self.taskBehavior.value
        aux.append(task)
        self.taskBehavior.accept(aux)
        
        setUserDefault()
    }
    
    func updateTask(_ task: TaskModel) {
        var aux = self.taskBehavior.value
        var indexAux = -1
        
        for (index,item) in aux.enumerated() {
            if item.id == task.id {
                indexAux = index
            }
        }
        
        aux[indexAux] = task
        self.taskBehavior.accept(aux)
        
        setUserDefault()
    }
    
    fileprivate func getData() {
        if getUserDefault() {
            return
        }
    }
    
    fileprivate func getUserDefault() -> Bool{
        let userDefaults = UserDefaults.standard
        do {
            let arrayUserDefault = try userDefaults.getObject(forKey: "tasks", castTo: [TaskModel].self)

            self.taskBehavior.accept(arrayUserDefault)
            
            return true
        } catch {
//            print(error.localizedDescription)
            return false
        }
    }
    
    fileprivate func setUserDefault() {
        let userDefaults = UserDefaults.standard
        let all = self.taskBehavior.value
        do {
            try userDefaults.setObject(all, forKey: "tasks")
        } catch {
//            print(error.localizedDescription)
        }
    }
}
