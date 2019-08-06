//
//  TaskDetailsRootVIew.swift
//  To-do list
//

import UIKit

class TaskDetailsRootVIew: UIView {
    
    private let navigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem(title: "New task")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        return navigationItem
    }()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = .white
        return navigationBar
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder = "Task title"
        return textField
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
        addSubview(titleTextField)
    }
    
    private func activateConstraints() {
        activateConstraintsNavigationBar()
        activateConstraintsTitleTextField()
    }
    
    private func activateConstraintsNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leading = navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0)
        let top = navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        let trailing = navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func activateConstraintsTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        let height = titleTextField.heightAnchor.constraint(equalToConstant: 45)
        let leading = titleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24)
        let top = titleTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 24)
        let trailing = titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24)
        NSLayoutConstraint.activate([height, top, leading, trailing])
    }
}
