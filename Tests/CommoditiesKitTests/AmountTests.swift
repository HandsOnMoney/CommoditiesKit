import Foundation
import Testing
@testable import CommoditiesKit

struct AmountTests {
    @Test func testKnownIntValueBug() {
        // https://stackoverflow.com/questions/79392691/weird-decimal-behavior-when-converting-to-int

        let amount = Amount(amount: Decimal(100.4449315513924) * 100, currency: .usd)
        #expect(amount.amountMinor == 1004449)
    }

    @Test func testInitFromDecimal() async throws {
        let amount = Amount(amount: 10.20, currency: .usd)
        #expect(amount.amountMinor == 1020)
    }

    @Test func testInitFromInt() async throws {
        let amount = Amount(amountMinor: 1020, currency: .usd)
        #expect(amount.amountMinor == 1020)
    }

    @Test func testInitFromDecimalJPY() async throws {
        let amount = Amount(amount: 10.20, currency: .jpy)

        #expect(amount.amountMinor == 10)
    }

    @Test func testInitFromIntJPY() async throws {
        let amount = Amount(amountMinor: 1020, currency: .jpy)

        #expect(amount.amountMinor == 1020)
    }

    @Test func testAddition() throws {
        #expect(Amount(amount: 10.20, currency: .usd) + Amount(amount: 10.00, currency: .usd) == Amount(amount: 20.20, currency: .usd))
        #expect(Amount(amountMinor: 1020, currency: .usd) + Amount(amountMinor: 1000, currency: .usd) == Amount(amount: 20.20, currency: .usd))
    }

    @Test func testSubstraction() throws {
        #expect(Amount(amount: 10.20, currency: .usd) - Amount(amount: 10.00, currency: .usd) == Amount(amount: 0.20, currency: .usd))
        #expect(Amount(amountMinor: 1020, currency: .usd) - Amount(amountMinor: 1000, currency: .usd) == Amount(amount: 0.20, currency: .usd))
        #expect(Amount(amount: 10.20, currency: .usd) - Amount(amount: 20.00, currency: .usd) == Amount(amount: -9.80, currency: .usd))
        #expect(Amount(amountMinor: 1020, currency: .usd) - Amount(amountMinor: 2000, currency: .usd) == Amount(amount: -9.80, currency: .usd))
    }

    @Test func testMultiplication() throws {
        let actual = Amount(amount: 10.20, currency: .usd) * Decimal(string: "137.23")!
        let expected = Amount(amountMinor: 139975, currency: .usd)
        #expect(actual == expected)
    }

    @Test func testExchange() {
        let actual = Amount(amount: 1000, currency: .usd).exchange(for: .jpy, at: 150.2)
        #expect(actual == Amount(amount: 150200, currency: .jpy))

        let actual2 = Amount(amount: 1000, currency: .jpy).exchange(for: .usd, at: 0.0066)
        #expect(actual2 == Amount(amount: 6.60, currency: .usd))

        #expect(Amount(amountMinor: 0, currency: .jpy).exchange(for: .usd, at: 2.0) == Amount(amountMinor: 0, currency: .usd))
    }

    @Test func testExchangeWithMultipleRates() throws {
        var actual = try Amount(amount: 1000, currency: .usd).exchange(for: .jpy, using: [CommodityPair(.usd, .jpy): Decimal(string: "150.2")!])
        #expect(actual == Amount(amount: 150200, currency: .jpy))

        actual = try Amount(amount: 1000, currency: .usd).exchange(for: .usd, using: [CommodityPair(.usd, .usd): Decimal(string: "2")!])
        #expect(actual == Amount(amount: 1000, currency: .usd))

        #expect(throws: MissingPriceError(pair: CommodityPair(.usd, .jpy)), performing: {
            try Amount(amount: 1000, currency: .usd).exchange(for: .jpy, using: [:])
        })
    }
}
