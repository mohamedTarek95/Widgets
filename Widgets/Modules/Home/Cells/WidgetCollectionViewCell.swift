//
//  WidgetCollectionViewCell.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//

import UIKit

class WidgetCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var contentLabel: UILabel!
    
    func setup(with viewModel: ViewModel) {
        contentLabel.text = viewModel.content
    }
}

extension WidgetCollectionViewCell {
    struct ViewModel {
        let content: String
    }
}
