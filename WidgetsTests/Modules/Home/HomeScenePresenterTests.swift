//
//  HomeScenePresenterTests.swift
//  WidgetsTests
//
//  Created by Mohamed Tarek on 25/08/2023.
//

@testable import Widgets
import XCTest

class HomeScenePresenterTests: XCTestCase {
    var presenter: HomeScenePresenter!
    var viewControllerSpy: ViewControllerSpy!

    override func setUp() {
        super.setUp()
        viewControllerSpy = ViewControllerSpy()
        presenter = HomeScenePresenter(displayView: viewControllerSpy)
    }

    override func tearDown() {
        super.tearDown()
        viewControllerSpy = nil
        presenter = nil
    }

    // MARK: - Tests

    // MARK: - presentWidgets Tests

    func testFetchWidgets_CallsDisplayWidgets() throws {
        // Given
        let response: HomeScene.FetchWidgets.Response = [
            .init(style: .large, title: "large title", content: "large content"),
            .init(style: .mini, title: "mini title", content: "mini content"),
            .init(style: .square, title: "square title", content: "square content"),
        ]

        // When
        presenter.presentWidgets(response)

        // Then
        XCTAssertEqual(viewControllerSpy.displayWidgetsCallCount, 1)
        let viewModel = try XCTUnwrap(viewControllerSpy.displayWidgetsViewModel)
        XCTAssertEqual(viewModel.items.count, response.count)
        XCTAssertEqual(viewModel.items[0].content, "large content")
        XCTAssertEqual(viewModel.items[1].content, "square content")
        XCTAssertEqual(viewModel.items[2].content, "mini title")
    }

    // MARK: - constructOddSectionFrom Tests

    func testConstructOddSectionFrom_ZeroSquaresAndThreeMinis() throws {
        // Given
        var allGroups: [HomeScene.FetchWidgets.GroupedWidgets] = [
            .init(widgets: .init(repeating: .stub(), count: 3), groupStyle: .fullSize),
        ]
        let remainderSquareItems: [Widgets.Fetch.Widget] = []
        let remainderMiniItems: [Widgets.Fetch.Widget] = .init(repeating: .stub(style: .mini),
                                                               count: 3)

        // When
        presenter.constructOddSectionFrom(remainderSquareItems: remainderSquareItems,
                                          remainderMiniItems: remainderMiniItems,
                                          allGroups: &allGroups)

        // Then
        XCTAssertEqual(allGroups.last?.groupStyle, .quadruples)
        XCTAssertEqual(allGroups.last?.widgets.count, 3)
        XCTAssert(allGroups.last?.widgets.allSatisfy { $0.style == .mini } == true)
    }

    func testConstructOddSectionFrom_OneSquareAndZeroMinis() throws {
        // Given
        var allGroups: [HomeScene.FetchWidgets.GroupedWidgets] = [
            .init(widgets: .init(repeating: .stub(), count: 3), groupStyle: .fullSize),
        ]
        let remainderSquareItems: [Widgets.Fetch.Widget] = [.stub(style: .square)]
        let remainderMiniItems: [Widgets.Fetch.Widget] = []

        // When
        presenter.constructOddSectionFrom(remainderSquareItems: remainderSquareItems,
                                          remainderMiniItems: remainderMiniItems,
                                          allGroups: &allGroups)

        // Then
        XCTAssertEqual(allGroups.last?.groupStyle, .mixed)
        XCTAssertEqual(allGroups.last?.widgets.count, 1)
        XCTAssert(allGroups.last?.widgets.allSatisfy { $0.style == .square } == true)
    }

    func testConstructOddSectionFrom_OneSquareAndThreeMinis() throws {
        // Given
        var allGroups: [HomeScene.FetchWidgets.GroupedWidgets] = [
            .init(widgets: .init(repeating: .stub(), count: 3), groupStyle: .fullSize),
        ]
        let remainderSquareItems: [Widgets.Fetch.Widget] = [.stub(style: .square)]
        let remainderMiniItems: [Widgets.Fetch.Widget] = .init(repeating: .stub(style: .mini),
                                                               count: 3)

        // When
        presenter.constructOddSectionFrom(remainderSquareItems: remainderSquareItems,
                                          remainderMiniItems: remainderMiniItems,
                                          allGroups: &allGroups)

        // Then
        XCTAssertEqual(allGroups.last?.groupStyle, .mixed)
        XCTAssertEqual(allGroups.last?.widgets.count, 4)
        XCTAssert(allGroups.last?.widgets.first?.style == .square)
        XCTAssert(allGroups.last?.widgets.dropFirst().allSatisfy { $0.style == .mini } == true)
    }

    func testConstructOddSectionFrom_OneSquareAndZeroMinis_CombinedWithQudruples() throws {
        // Given
        var allGroups: [HomeScene.FetchWidgets.GroupedWidgets] = [
            .init(widgets: .init(repeating: .stub(), count: 3), groupStyle: .fullSize),
            .init(widgets: .init(repeating: .stub(style: .mini), count: 4), groupStyle: .quadruples),
        ]
        let remainderSquareItems: [Widgets.Fetch.Widget] = [.stub(style: .square)]
        let remainderMiniItems: [Widgets.Fetch.Widget] = []

        // When
        presenter.constructOddSectionFrom(remainderSquareItems: remainderSquareItems,
                                          remainderMiniItems: remainderMiniItems,
                                          allGroups: &allGroups)

        // Then
        let mixedGroup = try XCTUnwrap(allGroups.last(where: { $0.groupStyle == .mixed }))
        XCTAssertEqual(mixedGroup.widgets.count, 5)
        XCTAssert(mixedGroup.widgets.first?.style == .square)
        XCTAssert(mixedGroup.widgets.dropFirst().allSatisfy { $0.style == .mini } == true)
    }
}

// MARK: - Test Doubles

extension HomeScenePresenterTests {
    class ViewControllerSpy: HomeSceneDisplayLogic {
        var displayWidgetsCallCount = 0
        var displayWidgetsViewModel: HomeScene.FetchWidgets.ViewModel? = nil

        func displayWidgets(_ viewModel: HomeScene.FetchWidgets.ViewModel) {
            displayWidgetsCallCount += 1
            displayWidgetsViewModel = viewModel
        }
    }
}
