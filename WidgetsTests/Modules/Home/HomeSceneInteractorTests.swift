//
//  HomeSceneInteractorTests.swift
//  WidgetsTests
//
//  Created by Mohamed Tarek on 24/08/2023.
//

@testable import Widgets
import XCTest

class HomeSceneInteractorTests: XCTestCase {
    var interactor: HomeSceneInteractor!
    var presenterSpy: PresenterSpy!

    override func setUp() {
        super.setUp()
        presenterSpy = PresenterSpy()
        interactor = HomeSceneInteractor(presenter: presenterSpy)
    }

    override func tearDown() {
        super.tearDown()
        presenterSpy = nil
        interactor = nil
    }

    // MARK: - Tests

    // MARK: - fetchWidgets Tests

    func testFetchWidgets_CallsPresentWidgets() throws {
        // When
        interactor.fetchWidgets()

        // Then
        XCTAssertEqual(presenterSpy.presentWidgetsCallCount, 1)

        // In a real world scenario you'd have to provide the data to the interactor through a worker stub and then here test that the interactor actually performs the business logic correctly
        XCTAssertNotNil(presenterSpy.presentWidgetsResponse)
    }
}

// MARK: - Test Doubles

extension HomeSceneInteractorTests {
    class PresenterSpy: HomeScenePresentationLogic {
        var presentWidgetsCallCount = 0
        var presentWidgetsResponse: HomeScene.FetchWidgets.Response? = nil

        func presentWidgets(_ response: HomeScene.FetchWidgets.Response) {
            presentWidgetsCallCount += 1
            presentWidgetsResponse = response
        }
    }
}
