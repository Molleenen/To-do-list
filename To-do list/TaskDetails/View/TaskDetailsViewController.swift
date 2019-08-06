//
//  TaskDetailsViewController.swift
//  To-do list
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    private let rootView: TaskDetailsRootVIew
    
    init(rootView: TaskDetailsRootVIew) {
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init(rootView:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
}
