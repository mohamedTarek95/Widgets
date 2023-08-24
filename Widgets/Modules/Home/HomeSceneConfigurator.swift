//
//  HomeSceneConfigurator.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  We are one more configurator closer to Egypt's First Unicorn 🦄
//

import UIKit

enum HomeSceneConfigurator {
    static func configure() -> UINavigationController {
        let viewController = HomeSceneViewController()
        let presenter = HomeScenePresenter(displayView: viewController)
        let interactor = HomeSceneInteractor(presenter: presenter)
        let router = HomeSceneRouter(viewController: viewController, dataStore: interactor)

        viewController.router = router
        viewController.interactor = interactor

        let nav = UINavigationController(rootViewController: viewController)

        return nav
    }
}
