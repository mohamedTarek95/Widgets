//
//  UIWindow+SwapRoot.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//

import UIKit

extension UIWindow {
    public func swapRootViewController(newController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        self.rootViewController?.dismiss(animated: false, completion: nil)
        self.rootViewController = newController
        completion?()
        
        if animated {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
