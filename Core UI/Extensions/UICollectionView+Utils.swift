//
//  UICollectionView+Utils.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//

import UIKit

public extension UICollectionView {
    func dequeueReusableCell<T>(indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
        guard let cell else {
            fatalError("Cell \(T.self) is not registered to collection view \(self)")
        }
        return cell
    }

    func register(_ klass: AnyClass, identifier: String? = nil) {
        let nibName = String(describing: klass.self)
        let identifier = identifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func cellAt<T>(indexPath: IndexPath) -> T? {
        let cell = cellForItem(at: indexPath) as? T
        return cell
    }
}
