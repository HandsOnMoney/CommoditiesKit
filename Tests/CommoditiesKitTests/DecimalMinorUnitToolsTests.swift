// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct DecimalMinorUnitToolsTests {
    @Test func of_WellKnownCurrencyCode_ReturnsMoneyWithCorrectCurrency() throws {
        let decimal = Decimal(100.50)
        let amount = try decimal.of("USD")

        #expect(amount.currency.mnemonic == "USD")
        #expect(amount.currency.digits == 2)
        #expect(amount.value == Decimal(100.50))
    }

    @Test func of_UnknownCurrencyCode_ThrowsError() {
        let decimal = Decimal(100)

        #expect(throws: CommodityError.unknownCurrencyCode(code: "INVALID"), performing: {
            try decimal.of("INVALID")
        })
    }

    @Test func of_CustomCurrencyCodeWithDigits_ReturnsMoneyWithCustomCurrency() {
        let decimal = Decimal(100.50)
        let amount = decimal.of("XXX", digits: 3)

        #expect(amount.currency.mnemonic == "XXX")
        #expect(amount.currency.digits == 3)
        #expect(amount.value == Decimal(100.50))
    }

    @Test func of_CurrencyUnit_ReturnsMoneyWithGivenCurrency() {
        let decimal = Decimal(100.50)
        let currency = Commodity(mnemonic: "XXX", digits: 2)
        let amount = decimal.of(currency)

        #expect(amount.currency == currency)
        #expect(amount.value == Decimal(100.50))
    }

    @Test func usd_ValidDecimal_ReturnsUSDMoney() {
        let decimal = Decimal(50.25)
        let amount = decimal.usd

        #expect(amount.currency.mnemonic == "USD")
        #expect(amount.currency.digits == 2)
        #expect(amount.value == Decimal(50.25))
    }

    @Test func eur_ValidDecimal_ReturnsEURMoney() {
        let decimal = Decimal(75.99)
        let amount = decimal.eur

        #expect(amount.currency.mnemonic == "EUR")
        #expect(amount.currency.digits == 2)
    }

    @Test func jpy_ValidDecimal_ReturnsJPYMoney() {
        let decimal = Decimal(1000)
        let amount = decimal.jpy

        #expect(amount.currency.mnemonic == "JPY")
        #expect(amount.currency.digits == 0)
    }

    @Test func gbp_ValidDecimal_ReturnsGBPMoney() {
        let decimal = Decimal(25.50)
        let amount = decimal.gbp

        #expect(amount.currency.mnemonic == "GBP")
        #expect(amount.currency.digits == 2)
    }

    @Test func cad_ValidDecimal_ReturnsCADMoney() {
        let decimal = Decimal(100)
        let amount = decimal.cad

        #expect(amount.currency.mnemonic == "CAD")
        #expect(amount.currency.digits == 2)
    }

    @Test func aud_ValidDecimal_ReturnsAUDMoney() {
        let decimal = Decimal(50)
        let amount = decimal.aud

        #expect(amount.currency.mnemonic == "AUD")
        #expect(amount.currency.digits == 2)
    }

    @Test func chf_ValidDecimal_ReturnsChfMoney() {
        let decimal = Decimal(30)
        let amount = decimal.chf

        #expect(amount.currency.mnemonic == "CHF")
        #expect(amount.currency.digits == 2)
    }

    @Test func cny_ValidDecimal_ReturnsCNYMoney() {
        let decimal = Decimal(500)
        let amount = decimal.cny

        #expect(amount.currency.mnemonic == "CNY")
        #expect(amount.currency.digits == 2)
    }

    @Test func hkd_ValidDecimal_ReturnsHKDMoney() {
        let decimal = Decimal(100)
        let amount = decimal.hkd

        #expect(amount.currency.mnemonic == "HKD")
        #expect(amount.currency.digits == 2)
    }

    @Test func sek_ValidDecimal_ReturnsSEKMoney() {
        let decimal = Decimal(200)
        let amount = decimal.sek

        #expect(amount.currency.mnemonic == "SEK")
        #expect(amount.currency.digits == 2)
    }
}
