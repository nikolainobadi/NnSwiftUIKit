public extension Array where Element: Identifiable {
    mutating func toggleItem(_ item: Element) {
        if let index = self.firstIndex(where: { $0.id == item.id }) {
            self.remove(at: index)
        } else {
            self.append(item)
        }
    }
    
    mutating func addOrUpdate(_ item: Element) {
        if let index = self.firstIndex(where: { $0.id == item.id }) {
            self[index] = item
        } else {
            self.append(item)
        }
    }
}
