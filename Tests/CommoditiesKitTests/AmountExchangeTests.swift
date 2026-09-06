// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct AmountExchangeTests {
    @Test func exchange_SameCurrencyWithRate_ReturnsSameMoney() throws {
        let amount = Amount(amount: 1000, currency: .usd)
        let rates: [CommodityPair: Decimal] = [
            CommodityPair(.usd, .usd): Decimal(string: "2")!
        ]

        let result = try amount.exchange(for: .usd, using: rates)

        #expect(result == amount)
    }

    @Test func exchange_MissingRate_ThrowsError() {
        let amount = Amount(amount: 1000, currency: .usd)
        let rates: [CommodityPair: Decimal] = [:]

        #expect(throws: MissingPriceError(pair: CommodityPair(.usd, .jpy)), performing: {
            try amount.exchange(for: .jpy, using: rates)
        })
    }

    @Test func exchange_WithValidRate_ReturnsConvertedMoney() throws {
        let amount = Amount(amount: 1000, currency: .usd)
        let rates: [CommodityPair: Decimal] = [
            CommodityPair(.usd, .eur): Decimal(string: "0.92")!
        ]

        let result = try amount.exchange(for: .eur, using: rates)

        #expect(result.currency == .eur)
        #expect(result.value == Decimal(string: "920")!)
    }

    @Test func exchangeAtRate_USDToJPY_ReturnsCorrectMoney() {
        let amount = Amount(amount: 1000, currency: .usd)
        let result = amount.exchange(for: .jpy, at: 150.2)

        #expect(result.currency == .jpy)
        #expect(result.value == Decimal(string: "150200")!)
    }

    @Test func exchangeAtRate_JPYToUSD_ReturnsCorrectMoney() {
        let amount = Amount(amount: 1000, currency: .jpy)
        let result = amount.exchange(for: .usd, at: 0.0066)

        #expect(result.currency == .usd)
        #expect(result.value == Decimal(string: "6.60")!)
    }

    @Test func exchangeAtRate_ZeroMoneyWithRate_ReturnsZero() {
        let amount = Amount(amountMinor: 0, currency: .jpy)
        let result = amount.exchange(for: .usd, at: 2.0)

        #expect(result.isZero)
        #expect(result.currency == .usd)
    }
}
