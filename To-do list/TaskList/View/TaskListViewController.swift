//
//  TaskListViewController.swift
//  To-do list
//

import UIKit

class TaskListViewController: UIViewController {
    
    private let rootView: TaskListRootView
    private let viewModel: TaskListViewModel
    
    init(rootView: TaskListRootView, viewModel: TaskListViewModel) {
        self.rootView = rootView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.rootView.delegate = self
        self.rootView.dataSource = self
        self.rootView.createNewTaskHandler = { [weak self] in
            self?.presentNewTaskScreen()
        }
        self.viewModel.loadTasks()
        rootView.reloadData()
    }
    
    @available(*, unavailable, message: "Use init(rootView: viewModel:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.loadTasks()
        rootView.reloadData()
    }
    
    private func presentNewTaskScreen() {
        let rootView = TaskDetailsRootVIew()
        let viewModel = TaskDetailsViewModel(selectedTask: nil)
        let viewController = TaskDetailsViewController(rootView: rootView, viewModel: viewModel)
        present(viewController, animated: true, completion: nil)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.getNumberOfTasks()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath)
        let index = indexPath.row
        cell.textLabel?.text = viewModel.getTaskTitle(forIndex: index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            viewModel.deleteTask(withIndex: index)
            viewModel.loadTasks()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = viewModel.tasks[indexPath.row]
        let rootView = TaskDetailsRootVIew()
        let viewModel = TaskDetailsViewModel(selectedTask: selectedTask)
        let viewController = TaskDetailsViewController(rootView: rootView, viewModel: viewModel)
        present(viewController, animated: true, completion: nil)
    }
}
