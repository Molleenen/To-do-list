//
//  TaskListViewModel.swift
//  To-do list
//

import UIKit
import Foundation
import CoreData

class TaskListViewModel {
    
    let coreDataContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var tasks = [Task]()
    
    func loadTasks() {
        guard let context = coreDataContext else { return }
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try context.fetch(request)
        } catch {
            print("Error fetching items from context")
        }
    }
    
    func getNumberOfTasks() -> Int {
        return tasks.count
    }
    
    func getTaskTitle(forIndex index: Int) -> String? {
        return tasks[index].title
    }
}
