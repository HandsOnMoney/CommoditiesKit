// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct MoneyFunctionsTests {
    @Test func abs_PositiveMoney_ReturnsPositiveMoney() {
        let amount = Amount(amountMinor: 100, currency: .usd)
        let result = abs(amount)

        #expect(result == amount)
        #expect(result.amountMinor == 100)
    }

    @Test func abs_NegativeMoney_ReturnsPositiveMoney() {
        let amount = Amount(amountMinor: -100, currency: .usd)
        let result = abs(amount)

        #expect(result.amountMinor == 100)
        #expect(result.currency == .usd)
    }

    @Test func abs_ZeroMoney_ReturnsZero() {
        let amount = Amount(amountMinor: 0, currency: .usd)
        let result = abs(amount)

        #expect(result.isZero)
    }
}
