//
//  UIWindow+SwapRoot.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//

import UIKit

public extension UIWindow {
    func swapRootViewController(newController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        rootViewController?.dismiss(animated: false, completion: nil)
        rootViewController = newController
        completion?()

        if animated {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
