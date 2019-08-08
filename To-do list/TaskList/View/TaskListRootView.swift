//
//  TaskListRootView.swift
//  To-do list
//

import UIKit

class TaskListRootView: UIView {
    
    typealias CreateNewTaskHandler = () -> Void
    typealias EnterEditingModeHandler = () -> Void
    
    var createNewTaskHandler: CreateNewTaskHandler?
    var enterEditingModeHandler: EnterEditingModeHandler?
    
    var delegate: UITableViewDelegate? {
        get {
            return nil
        }
        set {
            tableView.delegate = newValue
        }
    }
    var dataSource: UITableViewDataSource? {
        get {
            return nil
        }
        set {
            tableView.dataSource = newValue
        }
    }
    
    private let navigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem(title: "To-do list")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewTask))
        return navigationItem
    }()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = .white
        return navigationBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TaskListCell.self, forCellReuseIdentifier: String(describing: TaskListCell.self))
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToWindow() {
        backgroundColor = .white
        setUpNavigatonBar()
        constructHierarchy()
        activateConstraints()
    }
    
    private func setUpNavigatonBar() {
        navigationBar.items = [navigationItem]
    }
    
    private func constructHierarchy() {
        addSubview(navigationBar)
        addSubview(tableView)
    }
    
    private func activateConstraints() {
        activateConstraintsNavigationBar()
        activateConstraintsTableView()
    }
    
    private func activateConstraintsNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leading = navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0)
        let top = navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        let trailing = navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func activateConstraintsTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let leading = tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0)
        let top = tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0)
        let trailing = tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        let bottom = tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
}

extension TaskListRootView {
    func disableEditButton() {
        UIView.animate(withDuration: 0.2) {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    func enableEditButton() {
        UIView.animate(withDuration: 0.2) {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadTableViewRow(at indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        tableView.reloadRows(at: [indexPath], with: animation)
    }
    
    func getTableView() -> UITableView {
        return tableView
    }
}

extension TaskListRootView {
    @objc private func createNewTask() {
        createNewTaskHandler?()
    }
    
    @objc private func toggleEditing() {
        enterEditingModeHandler?()
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
        navigationItem.rightBarButtonItem?.isEnabled = tableView.isEditing ? false : true
        for cell in tableView.visibleCells {
            if let cell = cell as? TaskListCell {
                cell.toggleDoneButtonVisibility(hidden: tableView.isEditing)
            }
        }
    }
}
