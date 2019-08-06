//
//  TaskDetailsRootVIew.swift
//  To-do list
//

import UIKit

class TaskDetailsRootVIew: UIView {
    
    typealias SaveTaskHandler = (String) -> Void
    typealias DismissViewHandler = () -> Void
    
    var dismissViewHandler: DismissViewHandler?
    var saveTaskHandler: SaveTaskHandler?
    
    private let navigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem(title: "New task")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        return navigationItem
    }()
    
    private let saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        return button
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
        saveButton.isEnabled = false
        titleTextField.delegate = self
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
        navigationItem.rightBarButtonItem = saveButton
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

extension TaskDetailsRootVIew: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if let text = updatedString {
            saveButton.isEnabled = !text.isEmpty ? true : false
        }
        return true
    }
}

extension TaskDetailsRootVIew {
    @objc private func saveTask() {
        if let taskTitle = titleTextField.text {
            saveTaskHandler?(taskTitle)
        }
    }
    @objc private func dismissView() {
        dismissViewHandler?()
    }
}
