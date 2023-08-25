//
//  HomeSceneViewController.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Come on picasso, draw me like one of your french girls 🎨
//

import UIKit

class HomeSceneViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Stored properties

    var interactor: HomeSceneBusinessLogic!
    var router: HomeSceneRoutingLogic!

    private var state: HomeScene.State = .idle

    @objc func randomizeCells() {
        interactor.fetchWidgets()
    }
}

// MARK: - View lifecycle

extension HomeSceneViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        interactor.fetchWidgets()
    }
}

// MARK: - HomeDisplayLogic Methods

extension HomeSceneViewController: HomeSceneDisplayLogic {
    func displayWidgets(_ viewModel: HomeScene.FetchWidgets.ViewModel) {
        state = .loaded(viewModel: viewModel)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: viewModel.layout)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension HomeSceneViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        switch state {
        case .idle:
            return 0
        case let .loaded(viewModel):
            return viewModel.items.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .idle:
            fatalError("Data incosistency in HomeSceneViewController")
        case let .loaded(viewModel):
            let cell: WidgetCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.setup(with: viewModel.items[indexPath.item])
            return cell
        }
    }
}

// MARK: - Helpers

private extension HomeSceneViewController {
    private func configureViews() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(WidgetCollectionViewCell.self)
        collectionView.dataSource = self
        navigationItem.title = "Widgets" // Should be placed in a constants file that maps it to its localized version
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .refresh, target: self, action: #selector(randomizeCells))
    }
}
