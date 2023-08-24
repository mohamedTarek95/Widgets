//
//  Widgets.swift
//  Widgets
//
//  Created by Mohamed Tarek on 22/08/2023.
//

import Foundation

enum Widgets {
    enum Fetch {}
}

extension Widgets.Fetch {
    typealias Output = [Widget]
}

extension Widgets.Fetch {
    struct Widget: Decodable {
        let style: Style
        let title: String
        let content: String
    }
}

extension Widgets.Fetch.Widget {
    enum Style: Decodable, CaseIterable, Comparable {
        case large, square, mini
    }
}
