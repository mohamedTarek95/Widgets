//
//  HomeSceneInteractor.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Looks like you're cooking something interesting 🚀
//

final class HomeSceneInteractor: HomeSceneDataStore {
    // MARK: - Stored properties
    let presenter: HomeScenePresentationLogic
    
    init(presenter: HomeScenePresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - HomeBusinessLogic methods
extension HomeSceneInteractor: HomeSceneBusinessLogic {
    func fetchWidgets() {
        let response: HomeScene.FetchWidgets.Response = (0 ..< 30).map { _ in
            generateRandomWidget()
        }
        presenter.presentWidgets(response)
    }
}

private extension HomeSceneInteractor {
    func generateRandomWidget() -> Widgets.Fetch.Widget {
        let title = "App"
        let content = randomString(length: Int.random(in: 300...600)).capitalized
        return .init(style: .allCases.randomElement()!,
                     title: title,
                     content: content)
    }
    
    func randomString(length: Int) -> String  {
        enum Statics {
            static let scalars = UnicodeScalar("a").value...UnicodeScalar("z").value
            static let characters = scalars.map { Character(UnicodeScalar($0)!) }
        }
        let result = (0..<length).map { _ in Statics.characters.randomElement()! }
        return String(result)
    }
}
