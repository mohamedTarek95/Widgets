//
//  Array+Chunked.swift
//  Widgets
//
//  Created by Mohamed Tarek on 23/08/2023.
//

import Foundation

extension Array {
    /// Splits an array into chunks of a specified size
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    /// Splits an array into chunks of a specified size
    /// - Returns: A tuple of a perfectly chunked array of arrays where the inner arrays are all equal in size and a remainder array for ayny remaining items that couldn't fit into a perfect chunk
    func perfectlyChunked(into size: Int) -> (perfectChunked: [[Element]], remainder: [Element]?) {
        let remainderCount = self.count % size
        let perfectArray: Self
        let remainder: Self?
        if remainderCount == 0 {
            perfectArray = self
            remainder = nil
        } else {
            perfectArray = self.sameDropLast(remainderCount)
            remainder = self.suffix(remainderCount)
        }
        return (perfectArray.chunked(into: size), remainder)
    }
    
    private func sameDropLast(_ k: Int) -> Self {
        Array(self.dropLast(k))
    }
}
