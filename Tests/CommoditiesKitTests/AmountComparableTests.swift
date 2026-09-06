// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct MoneyComparableTests {
    @Test func division_TwoMoneyInSameCurrency_ReturnsDivisorDecimal() {
        let amount1 = Amount(amount: 20.00, currency: .usd)
        let amount2 = Amount(amount: 10.00, currency: .usd)
        let result = amount1 / amount2

        #expect(result == Decimal(2))
    }

    @Test func lessThan_ComparingTwoMoneyInSameCurrency_ReturnsCorrectResult() {
        let amount1 = Amount(amountMinor: 100, currency: .usd)
        let amount2 = Amount(amountMinor: 200, currency: .usd)

        #expect(amount1 < amount2)
        #expect(!(amount2 < amount1))
    }

    @Test func lessThanOrEqual_ComparingEqualMoney_ReturnsTrue() {
        let amount1 = Amount(amountMinor: 100, currency: .usd)
        let amount2 = Amount(amountMinor: 100, currency: .usd)

        #expect(amount1 <= amount2)
    }

    @Test func greaterThan_ComparingTwoMoneyInSameCurrency_ReturnsCorrectResult() {
        let amount1 = Amount(amountMinor: 200, currency: .usd)
        let amount2 = Amount(amountMinor: 100, currency: .usd)

        #expect(amount1 > amount2)
        #expect(!(amount2 > amount1))
    }

    @Test func greaterThanOrEqual_ComparingEqualMoney_ReturnsTrue() {
        let amount1 = Amount(amountMinor: 100, currency: .usd)
        let amount2 = Amount(amountMinor: 100, currency: .usd)

        #expect(amount1 >= amount2)
    }

    @Test func notEqual_ComparingDifferentMoney_ReturnsTrue() {
        let amount1 = Amount(amountMinor: 100, currency: .usd)
        let amount2 = Amount(amountMinor: 200, currency: .usd)

        #expect(amount1 != amount2)
    }

    @Test func lessThanZero_PositiveMoney_ReturnsFalse() {
        let amount = Amount(amountMinor: 100, currency: .usd)

        #expect(!(amount < 0))
    }

    @Test func lessThanZero_NegativeMoney_ReturnsTrue() {
        let amount = Amount(amountMinor: -100, currency: .usd)

        #expect(amount < 0)
    }

    @Test func lessThanZero_ZeroMoney_ReturnsFalse() {
        let amount = Amount(amountMinor: 0, currency: .usd)

        #expect(!(amount < 0))
    }

    @Test func lessThanOrEqualZero_NegativeMoney_ReturnsTrue() {
        let amount = Amount(amountMinor: -100, currency: .usd)

        #expect(amount <= 0)
    }

    @Test func lessThanOrEqualZero_ZeroMoney_ReturnsTrue() {
        let amount = Amount(amountMinor: 0, currency: .usd)

        #expect(amount <= 0)
    }

    @Test func greaterThanZero_PositiveMoney_ReturnsTrue() {
        let amount = Amount(amountMinor: 100, currency: .usd)

        #expect(amount > 0)
    }

    @Test func greaterThanZero_NegativeMoney_ReturnsFalse() {
        let amount = Amount(amountMinor: -100, currency: .usd)

        #expect(!(amount > 0))
    }

    @Test func greaterThanZero_ZeroMoney_ReturnsFalse() {
        let amount = Amount(amountMinor: 0, currency: .usd)

        #expect(!(amount > 0))
    }

    @Test func greaterThanOrEqualZero_PositiveMoney_ReturnsTrue() {
        let amount = Amount(amountMinor: 100, currency: .usd)

        #expect(amount >= 0)
    }

    @Test func greaterThanOrEqualZero_ZeroMoney_ReturnsTrue() {
        let amount = Amount(amountMinor: 0, currency: .usd)

        #expect(amount >= 0)
    }

    @Test func isZero_ZeroMoney_ReturnsTrue() {
        let amount = Amount(amountMinor: 0, currency: .usd)

        #expect(amount.isZero)
    }

    @Test func isZero_NonZeroMoney_ReturnsFalse() {
        let amount = Amount(amountMinor: 100, currency: .usd)

        #expect(!amount.isZero)
    }

    @Test func negation_PositiveMoney_ReturnsNegative() {
        let amount = Amount(amountMinor: 100, currency: .usd)

        #expect(-amount == Amount(amountMinor: -100, currency: .usd))
    }

    @Test func negation_NegativeMoney_ReturnsPositive() {
        let amount = Amount(amountMinor: -100, currency: .usd)

        #expect(-amount == Amount(amountMinor: 100, currency: .usd))
    }

    @Test func negation_ZeroMoney_ReturnsZero() {
        let amount = Amount(amountMinor: 0, currency: .usd)

        #expect(-amount == amount)
    }

    @Test func negation_PreservesCurrency() {
        let amount = Amount(amountMinor: 100, currency: .eur)

        #expect((-amount).currency == .eur)
    }
}
