//
//  TaskDetailsRootVIew.swift
//  To-do list
//

import UIKit

class TaskDetailsRootVIew: UIView {
    
    typealias SaveTaskHandler = (String) -> Void
    typealias SaveChangesHandler = (String, Bool) -> Void
    typealias DismissViewHandler = () -> Void
    typealias ChangeDoneStateHandler = () -> Void
    
    var dismissViewHandler: DismissViewHandler?
    var saveTaskHandler: SaveTaskHandler?
    var saveChangesHandler: SaveChangesHandler?
    var changeDoneStateHandler: ChangeDoneStateHandler?
    
    private var isEditingTask = false
    
    private var taskTitle: String?
    private var isTaskDone: Bool?
    
    private let navigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem(title: "New task")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        return navigationItem
    }()
    
    private var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
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
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "notChecked"), for: .normal)
        button.addTarget(self, action: #selector(toggleDoneState), for: .touchUpInside)
        return button
    }()
    
    private let doneLabel: UILabel = {
        let label = UILabel()
        label.text = "Not completed"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        doneButton.isHidden = true
        doneLabel.isHidden = true
        saveButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

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
    
    func setEditingTaskMode(editedTask: Task) {
        isEditingTask = true
        taskTitle = editedTask.title
        isTaskDone = editedTask.isDone
        doneButton.isHidden = false
        doneLabel.isHidden = false
        saveButton.isEnabled = false
        if let isDone = isTaskDone, isDone {
            doneButton.setImage(UIImage(named: "checked"), for: .normal)
            doneLabel.text = "Completed"
        } else {
            doneButton.setImage(UIImage(named: "notChecked"), for: .normal)
            doneLabel.text = "Not Completed"
        }
        navigationItem.title = "Task details"
        if let title = taskTitle {
            titleTextField.text = title
        }
    }
    
    private func setUpNavigatonBar() {
        navigationItem.rightBarButtonItem = saveButton
        navigationBar.items = [navigationItem]
    }
    
    private func constructHierarchy() {
        addSubview(navigationBar)
        addSubview(titleTextField)
        addSubview(doneButton)
        addSubview(doneLabel)
    }
    
    private func activateConstraints() {
        activateConstraintsNavigationBar()
        activateConstraintsTitleTextField()
        activateConstraintsDoneButton()
        activateConstraintsDoneLabel()
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
    
    private func activateConstraintsDoneButton() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        let width = doneButton.widthAnchor.constraint(equalToConstant: 25)
        let height = doneButton.heightAnchor.constraint(equalToConstant: 25)
        let leading = doneButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24)
        let top = doneButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24)
        NSLayoutConstraint.activate([width, height, top, leading])
    }
    
    private func activateConstraintsDoneLabel() {
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = doneLabel.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 16)
        let centerY = doneLabel.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, centerY])
    }
}

extension TaskDetailsRootVIew {
    @objc private func saveTask() {
        guard let taskTitle = titleTextField.text else { return }
        if isEditingTask, let isDone = isTaskDone {
            saveChangesHandler?(taskTitle, isDone)
        } else {
            saveTaskHandler?(taskTitle)
        }
    }
    @objc private func dismissView() {
        dismissViewHandler?()
    }
    
    @objc private func toggleDoneState() {
        changeDoneStateHandler?()
        saveButton.isEnabled = true
        UIView.animate(withDuration: 0.5) {
            guard let isTaskDone = self.isTaskDone else { return }
            if isTaskDone {
                self.doneButton.setImage(UIImage(named: "notChecked"), for: .normal)
                self.doneLabel.text = "Not completed"
                self.isTaskDone = !isTaskDone
            } else {
                self.doneButton.setImage(UIImage(named: "checked"), for: .normal)
                self.doneLabel.text = "Completed"
                self.isTaskDone = !isTaskDone
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), text != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
