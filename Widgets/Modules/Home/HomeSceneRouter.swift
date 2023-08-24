//
//  HomeSceneRouter.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeSceneRouter: HomeSceneDataPassing {
    // MARK: - Stored properties

    weak var viewController: HomeSceneViewController?
    let dataStore: HomeSceneDataStore

    init(viewController: HomeSceneViewController, dataStore: HomeSceneDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: - HomeSceneRoutingLogic Methods

extension HomeSceneRouter: HomeSceneRoutingLogic {}
