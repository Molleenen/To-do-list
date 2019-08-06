//
//  TaskDetailsViewController.swift
//  To-do list
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    private let rootView: TaskDetailsRootVIew
    private let viewModel: TaskDetailsViewModel
    
    init(rootView: TaskDetailsRootVIew, viewModel: TaskDetailsViewModel) {
        self.rootView = rootView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init(rootView: viewModel:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
}
