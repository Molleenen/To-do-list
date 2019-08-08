//
//  TaskDetailsViewModel.swift
//  To-do list
//

import UIKit
import Foundation
import CoreData

class TaskDetailsViewModel {
    
    let coreDataContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var selectedTask: Task?
    
    init(selectedTask: Task?) {
        self.selectedTask = selectedTask
    }
    
    func addNewTask(withTitle title: String) {
        if let context = coreDataContext {
            let newTask = Task(context: context)
            newTask.title = title
            newTask.isDone = false
            saveContext()
        }
    }
    
    func saveChanges(newTitle: String, isDone: Bool) {
        selectedTask?.setValue(newTitle, forKey: "title")
        selectedTask?.setValue(isDone, forKey: "isDone")
        saveContext()
    }
    
    private func saveContext(){
        do {
            try coreDataContext?.save()
        } catch {
            print("Error saving context")
        }
    }
}
