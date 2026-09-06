// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct CurrencyPairTests {
    @Test func init_TwoCurrencies_CreatesPair() {
        let pair = CommodityPair(.usd, .jpy)

        #expect(pair.from == .usd)
        #expect(pair.to == .jpy)
    }

    @Test func description_ValidPair_ReturnsFormattedString() {
        let pair = CommodityPair(.usd, .jpy)

        #expect(pair.description == "USDJPY")
    }

    @Test func hashable_SamePair_SameHash() {
        let pair1 = CommodityPair(.usd, .jpy)
        let pair2 = CommodityPair(.usd, .jpy)

        #expect(pair1.hashValue == pair2.hashValue)
    }

    @Test func hashable_DifferentPairs_CanBeUsedInDictionary() {
        let pair1 = CommodityPair(.usd, .jpy)
        let pair2 = CommodityPair(.usd, .eur)

        var dict: [CommodityPair: Decimal] = [:]
        dict[pair1] = Decimal(150.2)
        dict[pair2] = Decimal(1.1)

        #expect(dict[pair1] == Decimal(150.2))
        #expect(dict[pair2] == Decimal(1.1))
    }

    @Test func sendable_ValidPair_ConformsToSendable() {
        let pair = CommodityPair(.usd, .jpy)

        let _: CommodityPair = pair
    }
}
