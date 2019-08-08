//
//  TaskListCell.swift
//  To-do list
//

import UIKit

protocol TaskListCellDelegate: class {
    func taskListCell(_ cell: UITableViewCell, didPressButton: UIButton)
}

class TaskListCell: UITableViewCell {
    
    weak var delegate: TaskListCellDelegate?
    
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
        doneButton.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
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

extension TaskListCell {
    @objc private func handleButtonPress(_ sender: UIButton) {
//        if self.doneButton.currentImage == UIImage(named: "checked") {
//            self.doneButton.setImage(UIImage(named: "notChecked"), for: .normal)
//        } else {
//            self.doneButton.setImage(UIImage(named: "checked"), for: .normal)
//        }
        self.delegate?.taskListCell(self, didPressButton: sender)
    }
}
