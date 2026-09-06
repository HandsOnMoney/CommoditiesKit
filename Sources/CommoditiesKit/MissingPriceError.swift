import Foundation

public struct MissingPriceError: LocalizedError, Equatable {
    public let pair: CommodityPair

    public init(pair: CommodityPair) {
        self.pair = pair
    }

    public var errorDescription: String? {
        "Can not find exchange rate for \(pair)"
    }
}
