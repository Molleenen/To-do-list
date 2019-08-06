//
//  TaskDetailsViewModel.swift
//  To-do list
//

import UIKit
import Foundation
import CoreData

class TaskDetailsViewModel {
    
    let coreDataContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addNewTask(withTitle title: String) {
        if let context = coreDataContext {
            let newTask = Task(context: context)
            newTask.title = title
            newTask.isDone = false
            
            saveNewItem()
        }
    }
    
    private func saveNewItem(){
        do {
            try coreDataContext?.save()
        } catch {
            print("Error saving context")
        }
    }
}
