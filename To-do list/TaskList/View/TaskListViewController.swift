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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TaskListCell.self),
            for: indexPath) as? TaskListCell
        else { return TaskListCell() }
        cell.configureCell(title: viewModel.getTaskTitle(forIndex: indexPath.row), isDone: viewModel.getTaskDoneState(forIndex: indexPath.row))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            viewModel.deleteTask(withIndex: index)
            viewModel.loadTasks()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        rootView.disableEditButton()
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        rootView.enableEditButton()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = viewModel.tasks[indexPath.row]
        let rootView = TaskDetailsRootVIew()
        let viewModel = TaskDetailsViewModel(selectedTask: selectedTask)
        let viewController = TaskDetailsViewController(rootView: rootView, viewModel: viewModel)
        present(viewController, animated: true, completion: nil)
    }
}

extension TaskListViewController: TaskListCellDelegate {
    func taskListCell(_ cell: UITableViewCell, didPressButton: UIButton) {
        if let indexPath = rootView.getTableView().indexPath(for: cell) {
            viewModel.toggleIsDone(taskIndex: indexPath.row)
            rootView.reloadTableViewRow(at: indexPath, with: .automatic)
        }
    }
}
