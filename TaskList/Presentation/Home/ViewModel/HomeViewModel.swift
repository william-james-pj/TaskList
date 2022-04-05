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
    
    init() {
        getData()
    }
    
    func getTask() -> [TaskModel] {
        return taskList
    }
    
    func newTask(_ title: String, _ description: String) {
        let dateString = getDateString()
        
        let task = TaskModel(title: title, description: description, dateString: dateString, subTasks: [])
        taskList.append(task)
        
        delegate?.reloadCollection()
        
        setUserDefault()
    }
    
    func updateSubTask(idTask: Int, subTasks: [SubTaskModel]) {
        self.taskList[idTask].subTasks = subTasks
        
        delegate?.reloadCollection()
        
        setUserDefault()
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
            
            self.taskList = arrayUserDefault
            
            return true
        } catch {
//            print(error.localizedDescription)
            return false
        }
    }
    
    fileprivate func setUserDefault() {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(self.taskList, forKey: "tasks")
        } catch {
//            print(error.localizedDescription)
        }
    }
}
