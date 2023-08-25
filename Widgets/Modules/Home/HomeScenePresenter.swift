//
//  HomeScenePresenter.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Just remember presenters take models and produce viewmodels
//

import UIKit

final class HomeScenePresenter {
    // MARK: - Stored properties

    weak var displayView: HomeSceneDisplayLogic?

    init(displayView: HomeSceneDisplayLogic) {
        self.displayView = displayView
    }
}

// MARK: - HomePresentationLogic Methods

extension HomeScenePresenter: HomeScenePresentationLogic {
    func presentWidgets(_ response: HomeScene.FetchWidgets.Response) {
        let styles = consturctStyles(from: response)
        displayView?.displayWidgets(styles)
    }
}

private extension HomeScenePresenter {
    func consturctStyles(from response: HomeScene.FetchWidgets.Response) -> HomeScene.FetchWidgets.ViewModel {
        let groupedWidgets = constructGroupedWidgets(from: response)

        let layoutItems: [NSCollectionLayoutItem] = groupedWidgets.compactMap {
            switch $0.groupStyle {
            case .fullSize:
                return constructFullSizeLayoutItem()
            case .fiftyFifty:
                return constructFiftyFiftyLayoutItem()
            case .quadruples:
                return constructQuadruplesLayoutItem()
            case .mixed:
                return constructMixedLayoutItem()
            }
        }

        let mainGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(1000))
        let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: mainGroupSize,
                                                         subitems: layoutItems)
        mainGroup.interItemSpacing = .fixed(8)
        let section = NSCollectionLayoutSection(group: mainGroup)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let items: [WidgetCollectionViewCell.ViewModel] = groupedWidgets
            .flatMap { $0.widgets }
            .map { .init(content: $0.style == .mini ? $0.title : $0.content) }

        return .init(layout: section,
                     items: items)
    }

    func constructGroupedWidgets(from response: HomeScene.FetchWidgets.Response) -> [HomeScene.FetchWidgets.GroupedWidgets] {
        let sortedResponse = response.sorted(by: { $0.style <= $1.style })
        let chunkedResponse = Dictionary(grouping: sortedResponse, by: { $0.style })

        var allGroups: [HomeScene.FetchWidgets.GroupedWidgets] = []
        if let largeResponse = chunkedResponse[.large]?.chunked(into: 1) {
            largeResponse.forEach {
                let fullSizeGroup = HomeScene.FetchWidgets.GroupedWidgets(widgets: $0,
                                                                          groupStyle: .fullSize)
                allGroups.append(fullSizeGroup)
            }
        }

        let squareTupled = chunkedResponse[.square]?.perfectlyChunked(into: 2)
        let chunkedSquareItems = squareTupled?.perfectChunked
        if let chunkedSquareItems {
            chunkedSquareItems.forEach {
                let fiftyFiftyGroup = HomeScene.FetchWidgets.GroupedWidgets(widgets: $0,
                                                                            groupStyle: .fiftyFifty)
                allGroups.append(fiftyFiftyGroup)
            }
        }

        let miniTupled = chunkedResponse[.mini]?.perfectlyChunked(into: 4)
        let chunkedMiniItems = miniTupled?.perfectChunked
        if let chunkedMiniItems {
            chunkedMiniItems.forEach {
                let quadruplesGroup = HomeScene.FetchWidgets.GroupedWidgets(widgets: $0,
                                                                            groupStyle: .quadruples)
                allGroups.append(quadruplesGroup)
            }
        }

        allGroups.shuffle() // To generate some randomness in the groups

        let remainderSquareItems = squareTupled?.remainder ?? []
        let remainderMiniItems = miniTupled?.remainder ?? []

        switch (remainderSquareItems.isEmpty, remainderMiniItems.isEmpty) {
        case (true, false):
            let mixedGroup = HomeScene.FetchWidgets.GroupedWidgets(widgets: remainderMiniItems,
                                                                   groupStyle: .quadruples)
            allGroups.append(mixedGroup)
        case (false, true) where allGroups.contains(where: { $0.groupStyle == .quadruples }):
            let quadrupleIndex = allGroups.lastIndex(where: { $0.groupStyle == .quadruples })!
            allGroups[quadrupleIndex] = HomeScene.FetchWidgets.GroupedWidgets(widgets: remainderSquareItems + allGroups[quadrupleIndex].widgets,
                                                                              groupStyle: .mixed)
        default:
            let mixedItems: [Widgets.Fetch.Widget] = remainderSquareItems + remainderMiniItems
            let mixedGroup = HomeScene.FetchWidgets.GroupedWidgets(widgets: mixedItems,
                                                                   groupStyle: .mixed)
            allGroups.append(mixedGroup)
        }

        return allGroups
    }

    func constructFullSizeLayoutItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        let fullGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitems: [item])
        return fullGroup
    }

    func constructFiftyFiftyLayoutItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 2)
        group.interItemSpacing = .fixed(8)
        return group
    }

    func constructQuadruplesLayoutItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 4)
        group.interItemSpacing = .fixed(8)
        return group
    }

    func constructMixedLayoutItem() -> NSCollectionLayoutItem? {
        let squareItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                    heightDimension: .fractionalHeight(1))
        let squareItem = NSCollectionLayoutItem(layoutSize: squareItemSize)
        squareItem.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 8)

        let miniItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1))
        let miniItem = NSCollectionLayoutItem(layoutSize: miniItemSize)
        let hGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(0.5))
        let hGroup = NSCollectionLayoutGroup.horizontal(layoutSize: hGroupSize,
                                                        repeatingSubitem: miniItem,
                                                        count: 2)
        hGroup.interItemSpacing = .fixed(8)

        let vGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                heightDimension: .fractionalHeight(1))
        let vGroup = NSCollectionLayoutGroup.vertical(layoutSize: vGroupSize,
                                                      repeatingSubitem: hGroup,
                                                      count: 2)
        vGroup.interItemSpacing = .fixed(8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [squareItem, vGroup])

        return group
    }
}
