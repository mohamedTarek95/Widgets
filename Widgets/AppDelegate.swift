//
//  AppDelegate.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    static var keyWindow: UIWindow? {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)?.window
        }
        set {
            (UIApplication.shared.delegate as? AppDelegate)?.window = newValue
        }
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = AppDelegate.keyWindow ?? UIWindow(frame: UIScreen.main.bounds)
        AppDelegate.keyWindow = window
        let controller = HomeSceneConfigurator.configure()
        controller.view.frame = UIScreen.main.bounds
        controller.view.layoutIfNeeded()
        window.makeKeyAndVisible()
        window.swapRootViewController(newController: controller, animated: false, completion: nil)
        return true
    }
}
