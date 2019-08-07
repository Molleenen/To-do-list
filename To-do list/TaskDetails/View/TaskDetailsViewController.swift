//
//  TaskDetailsViewController.swift
//  To-do list
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    private let rootView: TaskDetailsRootVIew
    private let viewModel: TaskDetailsViewModel
    
    init(rootView: TaskDetailsRootVIew, viewModel: TaskDetailsViewModel) {
        self.rootView = rootView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.rootView.saveTaskHandler = { [weak self] title in
            self?.saveTask(withTitle: title)
        }
        self.rootView.saveChangesHandler = { [weak self] title in
            self?.saveChanges(newTitle: title)
        }
        self.rootView.dismissViewHandler = { [weak self] in
            self?.dismissView()
        }
        if let editedTask = viewModel.selectedTask {
            self.rootView.setEditingTaskMode(editedTask: editedTask)
        }
    }
    
    @available(*, unavailable, message: "Use init(rootView: viewModel:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    private func saveTask(withTitle title: String) {
        viewModel.addNewTask(withTitle: title)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func saveChanges(newTitle: String) {
        viewModel.saveChanges(newTitle: newTitle)
        self.dismissView()
    }
    
    private func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}
