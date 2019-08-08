//
//  TaskListCell.swift
//  To-do list
//

import UIKit

class TaskListCell: UITableViewCell {
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    private let taskTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        constructHierarchy()
        activateConstraints()
    }
    
    private func constructHierarchy() {
        addSubview(doneButton)
        addSubview(taskTitle)
    }
    
    private func activateConstraints() {
        activateConstraintsDoneButton()
        activateConstraintsTaskTitle()
    }
    
    private func activateConstraintsDoneButton() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        let top = doneButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11)
        let leading = doneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11)
        let height = doneButton.heightAnchor.constraint(equalToConstant: 30)
        let width = doneButton.widthAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([top, leading, height, width])
    }
    
    private func activateConstraintsTaskTitle() {
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        let leading = taskTitle.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 16)
        let centerY = taskTitle.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, centerY])
    }
    
    func configureCell(title: String, isDone: Bool) {
        taskTitle.text = title
        if isDone {
            doneButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            doneButton.setImage(UIImage(named: "notChecked"), for: .normal)
        }
    }
}
