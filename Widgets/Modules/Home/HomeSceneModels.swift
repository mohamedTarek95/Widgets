//
//  HomeSceneModels.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Let's model it 🕺🏽💃🏽
//
//  Type "usecase" for some magic!

import UIKit

enum HomeScene {
    enum State {
        case idle
        case loaded(viewModel: HomeScene.FetchWidgets.ViewModel)
    }
    enum FetchWidgets {}
}

extension HomeScene.FetchWidgets {
    typealias Response = Widgets.Fetch.Output
    struct ViewModel {
        let layout: NSCollectionLayoutSection
        let items: [WidgetCollectionViewCell.ViewModel]
    }
}

extension HomeScene.FetchWidgets {
    struct GroupedWidgets {
        let widgets: [Widgets.Fetch.Widget]
        let groupStyle: Style
        
        enum Style {
            case fullSize, fiftyFifty, quadruples, mixed
        }
    }
}
