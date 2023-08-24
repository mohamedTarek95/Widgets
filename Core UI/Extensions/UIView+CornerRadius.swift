//
//  UIView+CornerRadius.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
