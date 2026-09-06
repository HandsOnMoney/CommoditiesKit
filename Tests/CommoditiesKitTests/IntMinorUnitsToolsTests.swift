// llm-generated
import Foundation
import Testing
@testable import CommoditiesKit

struct IntMinorUnitsToolsTests {
    @Test func of_WellKnownCurrencyCode_ReturnsMoneyWithCorrectCurrency() throws {
        let int = 1050
        let amount = try int.of("USD")

        #expect(amount.currency.mnemonic == "USD")
        #expect(amount.currency.digits == 2)
        #expect(amount.amountMinor == 1050)
    }

    @Test func of_UnknownCurrencyCode_ThrowsError() {
        let int = 100

        #expect(throws: CommodityError.unknownCurrencyCode(code: "INVALID"), performing: {
            try int.of("INVALID")
        })
    }

    @Test func of_CustomCurrencyCodeWithDigits_ReturnsMoneyWithCustomCurrency() {
        let int = 1050
        let amount = int.of("XXX", digits: 3)

        #expect(amount.currency.mnemonic == "XXX")
        #expect(amount.currency.digits == 3)
        #expect(amount.amountMinor == 1050)
    }

    @Test func of_CurrencyUnit_ReturnsMoneyWithGivenCurrency() {
        let int = 1050
        let currency = Commodity(mnemonic: "XXX", digits: 2)
        let amount = int.of(currency)

        #expect(amount.currency == currency)
        #expect(amount.amountMinor == 1050)
    }

    @Test func usdCents_ValidInt_ReturnsUSDMoney() {
        let int = 5025
        let amount = int.usdCents

        #expect(amount.currency.mnemonic == "USD")
        #expect(amount.amountMinor == 5025)
    }

    @Test func eurCents_ValidInt_ReturnsEURMoney() {
        let int = 7599
        let amount = int.eurCents

        #expect(amount.currency.mnemonic == "EUR")
        #expect(amount.amountMinor == 7599)
    }

    @Test func pence_ValidInt_ReturnsGBPMoney() {
        let int = 2550
        let amount = int.pence

        #expect(amount.currency.mnemonic == "GBP")
        #expect(amount.amountMinor == 2550)
    }

    @Test func cadCents_ValidInt_ReturnsCADMoney() {
        let int = 10000
        let amount = int.cadCents

        #expect(amount.currency.mnemonic == "CAD")
        #expect(amount.amountMinor == 10000)
    }

    @Test func audCents_ValidInt_ReturnsAUDMoney() {
        let int = 5000
        let amount = int.audCents

        #expect(amount.currency.mnemonic == "AUD")
        #expect(amount.amountMinor == 5000)
    }

    @Test func rappen_ValidInt_ReturnsCHFMoney() {
        let int = 3000
        let amount = int.rappen

        #expect(amount.currency.mnemonic == "CHF")
        #expect(amount.amountMinor == 3000)
    }

    @Test func fen_ValidInt_ReturnsCNYMoney() {
        let int = 50000
        let amount = int.fen

        #expect(amount.currency.mnemonic == "CNY")
        #expect(amount.amountMinor == 50000)
    }

    @Test func hkdCents_ValidInt_ReturnsHKDMoney() {
        let int = 10000
        let amount = int.hkdCents

        #expect(amount.currency.mnemonic == "HKD")
        #expect(amount.amountMinor == 10000)
    }

    @Test func sekOre_ValidInt_ReturnsSEKMoney() {
        let int = 20000
        let amount = int.sekOre

        #expect(amount.currency.mnemonic == "SEK")
        #expect(amount.amountMinor == 20000)
    }

    @Test func usdMinor_ValidInt_ReturnsUSDMoney() {
        let int = 5025
        let amount = int.usdMinor

        #expect(amount.currency.mnemonic == "USD")
        #expect(amount.currency.digits == 2)
        #expect(amount.amountMinor == 5025)
    }

    @Test func eurMinor_ValidInt_ReturnsEURMoney() {
        let int = 7599
        let amount = int.eurMinor

        #expect(amount.currency.mnemonic == "EUR")
        #expect(amount.currency.digits == 2)
    }

    @Test func jpy_ValidInt_ReturnsJPYMoney() {
        let int = 100000
        let amount = int.jpy

        #expect(amount.currency.mnemonic == "JPY")
        #expect(amount.currency.digits == 0)
        #expect(amount.amountMinor == 100000)
    }

    @Test func gbpMinor_ValidInt_ReturnsGBPMoney() {
        let int = 2550
        let amount = int.gbpMinor

        #expect(amount.currency.mnemonic == "GBP")
        #expect(amount.currency.digits == 2)
    }

    @Test func cadMinor_ValidInt_ReturnsCADMoney() {
        let int = 10000
        let amount = int.cadMinor

        #expect(amount.currency.mnemonic == "CAD")
        #expect(amount.currency.digits == 2)
    }

    @Test func audMinor_ValidInt_ReturnsAUDMoney() {
        let int = 5000
        let amount = int.audMinor

        #expect(amount.currency.mnemonic == "AUD")
        #expect(amount.currency.digits == 2)
    }

    @Test func chfMinor_ValidInt_ReturnsCHFMoney() {
        let int = 3000
        let amount = int.chfMinor

        #expect(amount.currency.mnemonic == "CHF")
        #expect(amount.currency.digits == 2)
    }

    @Test func cnyMinor_ValidInt_ReturnsCNYMoney() {
        let int = 50000
        let amount = int.cnyMinor

        #expect(amount.currency.mnemonic == "CNY")
        #expect(amount.currency.digits == 2)
    }

    @Test func hkdMinor_ValidInt_ReturnsHKDMoney() {
        let int = 10000
        let amount = int.hkdMinor

        #expect(amount.currency.mnemonic == "HKD")
        #expect(amount.currency.digits == 2)
    }

    @Test func sekMinor_ValidInt_ReturnsSEKMoney() {
        let int = 20000
        let amount = int.sekMinor

        #expect(amount.currency.mnemonic == "SEK")
        #expect(amount.currency.digits == 2)
    }
}
