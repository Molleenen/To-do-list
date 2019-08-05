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
    }
    
    private func activateConstraints() {
        activateConstraintsNavigationBar()
    }
    
    private func activateConstraintsNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leading = navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0)
        let top = navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        let trailing = navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
}
