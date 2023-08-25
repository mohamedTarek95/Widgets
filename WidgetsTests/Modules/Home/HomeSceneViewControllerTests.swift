//
//  HomeSceneViewControllerTests.swift
//  WidgetsTests
//
//  Created by Mohamed Tarek on 25/08/2023.
//

@testable import Widgets
import XCTest

final class HomeSceneViewControllerTests: XCTestCase {
    var viewController: HomeSceneViewController!
    var interactorSpy: InteractorSpy!
    var routerSpy: RouterSpy!

    override func setUp() {
        super.setUp()
        interactorSpy = InteractorSpy()
        routerSpy = RouterSpy()
        viewController = HomeSceneViewController()
        viewController.interactor = interactorSpy
        viewController.router = routerSpy
    }

    override func tearDown() {
        super.tearDown()
        interactorSpy = nil
        routerSpy = nil
        viewController = nil
    }

    // MARK: - Tests

    // MARK: - viewDidLoad Tests

    func testViewDidLoad_CallsFetchWidgets() {
        // When
        viewController.loadViewIfNeeded()

        // Then
        XCTAssertEqual(interactorSpy.fetchWidgetsCallCount, 1)
    }

    // MARK: - randomizeCells Tests

    func testRandomizeCells_CallsFetchWidgets() {
        // When
        viewController.randomizeCells()

        // Then
        XCTAssertEqual(interactorSpy.fetchWidgetsCallCount, 1)
    }
}

// MARK: - Test Doubles

extension HomeSceneViewControllerTests {
    class InteractorSpy: HomeSceneBusinessLogic {
        var fetchWidgetsCallCount = 0

        func fetchWidgets() {
            fetchWidgetsCallCount += 1
        }
    }

    class RouterSpy: HomeSceneRoutingLogic {}
}
