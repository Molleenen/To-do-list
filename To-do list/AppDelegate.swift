//
//  AppDelegate.swift
//  To-do list
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let taskListView: TaskListRootView = TaskListRootView()
        let taskListViewController: TaskListViewController = TaskListViewController(rootView: taskListView)
        window?.rootViewController = taskListViewController
        window?.makeKeyAndVisible()
        return true
    }
}
