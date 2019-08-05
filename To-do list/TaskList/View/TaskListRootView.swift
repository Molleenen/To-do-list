//
//  TaskListRootView.swift
//  To-do list
//

import UIKit

class TaskListRootView: UIView {
    
    private let navigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem(title: "To-do list")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        return navigationItem
    }()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = .white
        return navigationBar
    }()
    
    private let taskList: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
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
        addSubview(taskList)
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
        taskList.translatesAutoresizingMaskIntoConstraints = false
        let leading = taskList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0)
        let top = taskList.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0)
        let trailing = taskList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        let bottom = taskList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
}
