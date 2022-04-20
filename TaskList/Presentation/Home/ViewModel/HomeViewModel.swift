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
    fileprivate var toDoList: [TaskModel] = []
    fileprivate var progressList: [TaskModel] = []
    var delegate: HomeViewModelDelegate?
    
    init() {
        getData()
    }
    
    func getToDo() -> [TaskModel] {
        return toDoList
    }
    
    func getProgress() -> [TaskModel] {
        return progressList
    }
    
    func newTask(_ title: String, _ description: String, _ status: ETaskStatus) {
        let dateString = getDateString()
        
        let task = TaskModel(title: title, description: description, dateString: dateString, status: status, subTasks: [])
        
        if task.status == .progress {
            progressList.append(task)
        } else {
            toDoList.append(task)
        }
        
        delegate?.reloadCollection()
        
        setUserDefault()
    }
    
    func updateSubTask(idTask: Int, subTasks: [SubTaskModel]) {
//        self.taskList[idTask].subTasks = subTasks
//
//        delegate?.reloadCollection()
//
//        setUserDefault()
    }
    
    fileprivate func getData() {
        if getUserDefault() {
            return
        }
    }
    
    fileprivate func getDateString() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, d MMMM"
        return dateFormatter.string(from: now)
    }
    
    fileprivate func getUserDefault() -> Bool{
        let userDefaults = UserDefaults.standard
        do {
            let arrayUserDefault = try userDefaults.getObject(forKey: "tasks", castTo: [TaskModel].self)
            
            arrayUserDefault.forEach { task in
                if task.status == .progress {
                    self.progressList.append(task)
                    return
                }
                self.toDoList.append(task)
            }
            
            return true
        } catch {
//            print(error.localizedDescription)
            return false
        }
    }
    
    fileprivate func setUserDefault() {
        let userDefaults = UserDefaults.standard
        let all = toDoList + progressList
        do {
            try userDefaults.setObject(all, forKey: "tasks")
        } catch {
//            print(error.localizedDescription)
        }
    }
}
