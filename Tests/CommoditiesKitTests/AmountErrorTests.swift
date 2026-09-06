import Foundation
import Testing
@testable import CommoditiesKit

struct AmountErrorTests {
    @Test func missingPriceError_CurrencyPairProvided_ReturnsCorrectErrorDescription() {
        let pair = CommodityPair(.usd, .jpy)
        let error = MissingPriceError(pair: pair)

        #expect(error.errorDescription == "Can not find exchange rate for USDJPY")
    }

    @Test func missingPriceError_EquatableComparison_SamePair_ReturnsTrue() {
        let error1 = MissingPriceError(pair: CommodityPair(.usd, .jpy))
        let error2 = MissingPriceError(pair: CommodityPair(.usd, .jpy))

        #expect(error1 == error2)
    }

    @Test func missingPriceError_EquatableComparison_DifferentPair_ReturnsFalse() {
        let error1 = MissingPriceError(pair: CommodityPair(.usd, .jpy))
        let error2 = MissingPriceError(pair: CommodityPair(.usd, .eur))

        #expect(error1 != error2)
    }

    @Test func unknownCurrencyCode_InvalidCodeProvided_ReturnsCorrectErrorDescription() {
        let error = CommodityError.unknownCurrencyCode(code: "INVALID")

        #expect(error.errorDescription == "Currency code 'INVALID' is unknown")
    }

    @Test func unknownCurrencyCode_EquatableComparison_ReturnsTrue() {
        let error1 = CommodityError.unknownCurrencyCode(code: "INVALID")
        let error2 = CommodityError.unknownCurrencyCode(code: "INVALID")

        #expect(error1 == error2)
    }
}
