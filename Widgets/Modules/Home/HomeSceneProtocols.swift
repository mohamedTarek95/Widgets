//
//  HomeSceneProtocols.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Looks like you're cooking something interesting 🚀
//

protocol HomeSceneDisplayLogic: AnyObject {
    func displayWidgets(_ viewModel: HomeScene.FetchWidgets.ViewModel)
}

protocol HomeScenePresentationLogic {
    func presentWidgets(_ response: HomeScene.FetchWidgets.Response)
}

protocol HomeSceneDataStore {}

protocol HomeSceneRoutingLogic {}

protocol HomeSceneBusinessLogic {
    func fetchWidgets()
}

protocol HomeSceneDataPassing {
    var dataStore: HomeSceneDataStore { get }
}
