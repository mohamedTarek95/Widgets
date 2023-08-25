//
//  Widget+Stub.swift
//  WidgetsTests
//
//  Created by Mohamed Tarek on 25/08/2023.
//

@testable import Widgets

extension Widgets.Fetch.Widget {
    static func stub(style: Style = .large,
                     title: String = "title",
                     content: String = "content") -> Self
    {
        .init(style: style, title: title, content: content)
    }
}
