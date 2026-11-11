import Foundation

public enum NnTextLayout: Sendable {
    case unlimited
    case multiLine(limit: Int)
    case singleLineAutoSize(minScale: CGFloat)
}

public extension NnTextLayout {
    static let autoSize: NnTextLayout = .singleLineAutoSize(minScale: 0.5)
}
