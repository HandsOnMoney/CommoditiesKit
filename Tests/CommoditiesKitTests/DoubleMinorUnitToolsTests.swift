// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct DoubleMinorUnitToolsTests {
    @Test func of_WellKnownCurrencyCode_ReturnsMoneyWithCorrectCurrency() throws {
        let double = 100.50
        let amount = try double.of("USD")

        #expect(amount.currency.mnemonic == "USD")
        #expect(amount.currency.digits == 2)
    }

    @Test func of_UnknownCurrencyCode_ThrowsError() {
        let double = 100.0

        #expect(throws: CommodityError.unknownCurrencyCode(code: "INVALID"), performing: {
            try double.of("INVALID")
        })
    }

    @Test func of_CustomCurrencyCodeWithDigits_ReturnsMoneyWithCustomCurrency() {
        let double = 100.50
        let amount = double.of("XXX", digits: 3)

        #expect(amount.currency.mnemonic == "XXX")
        #expect(amount.currency.digits == 3)
    }

    @Test func of_CurrencyUnit_ReturnsMoneyWithGivenCurrency() {
        let double = 100.50
        let currency = Commodity(mnemonic: "XXX", digits: 2)
        let amount = double.of(currency)

        #expect(amount.currency == currency)
    }

    @Test func usd_ValidDouble_ReturnsUSDMoney() {
        let double = 50.25
        let amount = double.usd

        #expect(amount.currency.mnemonic == "USD")
        #expect(amount.currency.digits == 2)
    }

    @Test func eur_ValidDouble_ReturnsEURMoney() {
        let double = 75.99
        let amount = double.eur

        #expect(amount.currency.mnemonic == "EUR")
        #expect(amount.currency.digits == 2)
    }

    @Test func jpy_ValidDouble_ReturnsJPYMoney() {
        let double = 1000.0
        let amount = double.jpy

        #expect(amount.currency.mnemonic == "JPY")
        #expect(amount.currency.digits == 0)
    }

    @Test func gbp_ValidDouble_ReturnsGBPMoney() {
        let double = 25.50
        let amount = double.gbp

        #expect(amount.currency.mnemonic == "GBP")
        #expect(amount.currency.digits == 2)
    }

    @Test func cad_ValidDouble_ReturnsCADMoney() {
        let double = 100.0
        let amount = double.cad

        #expect(amount.currency.mnemonic == "CAD")
        #expect(amount.currency.digits == 2)
    }

    @Test func aud_ValidDouble_ReturnsAUDMoney() {
        let double = 50.0
        let amount = double.aud

        #expect(amount.currency.mnemonic == "AUD")
        #expect(amount.currency.digits == 2)
    }

    @Test func chf_ValidDouble_ReturnsCHFMoney() {
        let double = 30.0
        let amount = double.chf

        #expect(amount.currency.mnemonic == "CHF")
        #expect(amount.currency.digits == 2)
    }

    @Test func cny_ValidDouble_ReturnsCNYMoney() {
        let double = 500.0
        let amount = double.cny

        #expect(amount.currency.mnemonic == "CNY")
        #expect(amount.currency.digits == 2)
    }

    @Test func hkd_ValidDouble_ReturnsHKDMoney() {
        let double = 100.0
        let amount = double.hkd

        #expect(amount.currency.mnemonic == "HKD")
        #expect(amount.currency.digits == 2)
    }

    @Test func sek_ValidDouble_ReturnsSEKMoney() {
        let double = 200.0
        let amount = double.sek

        #expect(amount.currency.mnemonic == "SEK")
        #expect(amount.currency.digits == 2)
    }
}
