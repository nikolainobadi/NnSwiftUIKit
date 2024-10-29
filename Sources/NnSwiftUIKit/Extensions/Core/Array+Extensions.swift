//
//  Array+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 10/29/24.
//

public extension Array where Element: Identifiable {
    mutating func nnToggleItem(_ item: Element) {
        if let index = self.firstIndex(where: { $0.id == item.id }) {
            self.remove(at: index)
        } else {
            self.append(item)
        }
    }
    
    mutating func nnAddOrUpdate(_ item: Element) {
        if let index = self.firstIndex(where: { $0.id == item.id }) {
            self[index] = item
        } else {
            self.append(item)
        }
    }
}
