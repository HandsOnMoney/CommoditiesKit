// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct CurrencyUnitTests {
    @Test func init_ValidCodeAndDigits_CreatesInstance() {
        let currency = Commodity(mnemonic: "USD", digits: 2)

        #expect(currency.mnemonic == "USD")
        #expect(currency.digits == 2)
    }

    @Test func id_ValidCurrencyUnit_ReturnsFormattedString() {
        let currency = Commodity(mnemonic: "USD", digits: 2)

        #expect(currency.id == "CURRENCY:USD")
    }

    @Test func zero_ValidCurrencyUnit_ReturnsZeroMoney() {
        let currency = Commodity(mnemonic: "USD", digits: 2)
        let zero = currency.zero

        #expect(zero.amountMinor == 0)
        #expect(zero.currency == currency)
    }

    @Test func init_WellKnownCode_CreatesInstance() throws {
        let currency = try Commodity(wellKnownCode: "USD")

        #expect(currency.mnemonic == "USD")
        #expect(currency.digits == 2)
    }

    @Test func init_WellKnownCodeJPY_CreatesInstanceWithZeroDigits() throws {
        let currency = try Commodity(wellKnownCode: "JPY")

        #expect(currency.mnemonic == "JPY")
        #expect(currency.digits == 0)
    }

    @Test func init_UnknownCurrencyCode_ThrowsError() {
        #expect(throws: CommodityError.unknownCurrencyCode(code: "INVALID"), performing: {
            try Commodity(wellKnownCode: "INVALID")
        })
    }

    @Test func icon_ValidCurrencyCode_ReturnsIcon() {
        let currency = Commodity(mnemonic: "USD", digits: 2)

        #expect(currency.icon == "🇺🇸")
    }

    @Test func icon_UnknownCurrencyCode_ReturnsDefaultIcon() {
        let currency = Commodity(mnemonic: "UNKNOWN", digits: 2)

        #expect(currency.icon == "📃")
    }

    @Test func equatable_SameCurrencyUnits_ReturnsTrue() {
        let currency1 = Commodity(mnemonic: "USD", digits: 2)
        let currency2 = Commodity(mnemonic: "USD", digits: 2)

        #expect(currency1 == currency2)
    }

    @Test func equatable_DifferentCurrencyUnits_ReturnsFalse() {
        let currency1 = Commodity(mnemonic: "USD", digits: 2)
        let currency2 = Commodity(mnemonic: "JPY", digits: 0)

        #expect(currency1 != currency2)
    }

    @Test func hashable_SameCurrencyUnits_SameHash() {
        let currency1 = Commodity(mnemonic: "USD", digits: 2)
        let currency2 = Commodity(mnemonic: "USD", digits: 2)

        #expect(currency1.hashValue == currency2.hashValue)
    }

    @Test func wellKnownCurrencies_NoArguments_ReturnsAllCurrenciesSorted() {
        let currencies = Commodity.wellKnownCurrencies

        #expect(currencies.count > 0)
        #expect(currencies == currencies.sorted(by: { $0.mnemonic < $1.mnemonic }))
    }
}
