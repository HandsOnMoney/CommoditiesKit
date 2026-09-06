import Foundation

public struct CommodityPair: Hashable, CustomStringConvertible, Sendable {
    public let from: Commodity
    public let to: Commodity

    public init(_ from: Commodity, _ to: Commodity) {
        self.from = from
        self.to = to
    }

    public var description: String {
        from.mnemonic + to.mnemonic
    }
}
