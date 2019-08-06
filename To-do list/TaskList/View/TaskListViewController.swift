//
//  TaskListViewController.swift
//  To-do list
//

import UIKit

class TaskListViewController: UIViewController {
    private let rootView: TaskListRootView
    
    init(rootView: TaskListRootView) {
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
        self.rootView.delegate = self
        self.rootView.dataSource = self
        self.rootView.createNewTaskHandler = { [weak self] in
            self?.presentNewTaskScreen()
        }
    }
    
    @available(*, unavailable, message: "Use init(rootView:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    private func presentNewTaskScreen() {
        let rootView = TaskDetailsRootVIew()
        let viewController = TaskDetailsViewController(rootView: rootView)
        present(viewController, animated: true, completion: nil)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        return UITableViewCell()
    }
}
