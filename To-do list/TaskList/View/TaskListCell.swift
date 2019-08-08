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
        if isDone {
            let attributeString =  NSMutableAttributedString(string: title)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue,range: NSMakeRange(0, attributeString.length))
            taskTitle.attributedText = attributeString
            taskTitle.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            doneButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            taskTitle.text = title
            doneButton.setImage(UIImage(named: "notChecked"), for: .normal)
        }
    }
    
    func toggleDoneButtonVisibility(hidden: Bool) {
        if hidden {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.doneButton.alpha = 0.0
            }) { completed in
                self.doneButton.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.doneButton.isHidden = false
                self.doneButton.alpha = 1.0
            })
        }
    }
}

extension TaskListCell {
    @objc private func handleButtonPress(_ sender: UIButton) {
        self.delegate?.taskListCell(self, didPressButton: sender)
    }
}
