import Foundation
import Testing
@testable import CommoditiesKit

struct MixedAmountTests {

    // MARK: - init / zero

    @Test func zero_IsEmpty() {
        let mix = MixedAmount.zero
        #expect(mix.amounts.isEmpty)
    }

    @Test func initEmpty_IsEmpty() {
        let mix = MixedAmount()
        #expect(mix.amounts.isEmpty)
    }

    @Test func initWithAmounts_StoresAmounts() {
        let mix = MixedAmount([.usd: 100.usd, .eur: 200.eur])
        #expect(mix.amounts[.usd] == 100.usd)
        #expect(mix.amounts[.eur] == 200.eur)
    }

    @Test func initOptionalAmount_Nil_IsEmpty() {
        let mix = MixedAmount(nil as Amount?)
        #expect(mix.amounts.isEmpty)
    }

    @Test func initOptionalAmount_NonNil_StoresSingleEntry() {
        let mix = MixedAmount(100.usd as Amount?)
        #expect(mix.amounts[.usd] == 100.usd)
        #expect(mix.amounts.count == 1)
    }

    @Test func initArrayOfAmounts_Empty_IsEmpty() {
        let mix = MixedAmount([] as [Amount])
        #expect(mix.amounts.isEmpty)
    }

    @Test func initArrayOfAmounts_DifferentCurrencies_StoresEach() {
        let mix = MixedAmount([100.usd, 200.eur])
        #expect(mix.amounts[.usd] == 100.usd)
        #expect(mix.amounts[.eur] == 200.eur)
    }

    @Test func initArrayOfAmounts_SameCurrency_Accumulates() {
        let mix = MixedAmount([100.usd, 50.usd])
        #expect(mix.amounts[.usd] == 150.usd)
        #expect(mix.amounts.count == 1)
    }

    @Test func initArrayOfAmounts_SameCurrencyNetToZero_StoresZero() {
        let mix = MixedAmount([100.usd, (-100).usd])
        #expect(mix.amounts[.usd] == 0.usd)
    }

    // MARK: - Equatable

    @Test func equality_SameAmounts_Equal() {
        let a = MixedAmount([.usd: 100.usd])
        let b = MixedAmount([.usd: 100.usd])
        #expect(a == b)
    }

    @Test func equality_DifferentAmounts_NotEqual() {
        let a = MixedAmount([.usd: 100.usd])
        let b = MixedAmount([.usd: 200.usd])
        #expect(a != b)
    }

    @Test func equality_DifferentCurrencies_NotEqual() {
        let a = MixedAmount([.usd: 100.usd])
        let b = MixedAmount([.eur: 100.eur])
        #expect(a != b)
    }

    @Test func equality_ZeroEntryTreatedAsAbsent_EqualToEmpty() {
        let withZero = MixedAmount([.usd: 0.usd])
        #expect(withZero == MixedAmount.zero)
    }

    @Test func equality_ZeroEntryOnOneSize_EqualToEntrylessOtherSide() {
        let a = MixedAmount([.usd: 100.usd, .eur: 0.eur])
        let b = MixedAmount([.usd: 100.usd])
        #expect(a == b)
    }

    @Test func equality_BothHaveZeroForDifferentCurrencies_Equal() {
        let a = MixedAmount([.usd: 0.usd])
        let b = MixedAmount([.eur: 0.eur])
        #expect(a == b)
    }

    @Test func equality_NonZeroVsZeroEntry_NotEqual() {
        let a = MixedAmount([.usd: 100.usd])
        let b = MixedAmount([.usd: 0.usd])
        #expect(a != b)
    }

    // MARK: - MixedAmount + Amount

    @Test func addAmount_ToEmpty_ContainsThatAmount() {
        let mix = MixedAmount.zero + 100.usd
        #expect(mix.amounts[.usd] == 100.usd)
        #expect(mix.amounts.count == 1)
    }

    @Test func addAmount_SameCurrency_Accumulates() {
        let mix = MixedAmount.zero + 100.usd + 50.usd
        #expect(mix.amounts[.usd] == 150.usd)
    }

    @Test func addAmount_DifferentCurrencies_BothStored() {
        let mix = MixedAmount.zero + 100.usd + 200.eur
        #expect(mix.amounts[.usd] == 100.usd)
        #expect(mix.amounts[.eur] == 200.eur)
        #expect(mix.amounts.count == 2)
    }

    @Test func addAmount_NegativeAmount_Accumulates() {
        let mix = MixedAmount.zero + 100.usd + (-50).usd
        #expect(mix.amounts[.usd] == 50.usd)
    }

    // MARK: - MixedAmount - Amount

    @Test func subtractAmount_FromEmpty_IsNegative() {
        let mix = MixedAmount.zero - 100.usd
        #expect(mix.amounts[.usd] == (-100).usd)
    }

    @Test func subtractAmount_SameCurrency_Reduces() {
        let mix = MixedAmount([.usd: 150.usd]) - 50.usd
        #expect(mix.amounts[.usd] == 100.usd)
    }

    @Test func subtractAmount_DifferentCurrency_BothStored() {
        let mix = MixedAmount([.usd: 100.usd]) - 200.eur
        #expect(mix.amounts[.usd] == 100.usd)
        #expect(mix.amounts[.eur] == (-200).eur)
    }

    // MARK: - MixedAmount + MixedAmount

    @Test func addMixed_TwoSingleCurrency_Merges() {
        let a = MixedAmount([.usd: 100.usd])
        let b = MixedAmount([.usd: 50.usd])
        #expect((a + b).amounts[.usd] == 150.usd)
    }

    @Test func addMixed_OverlappingCurrencies_Accumulates() {
        let a = MixedAmount([.usd: 100.usd, .eur: 50.eur])
        let b = MixedAmount([.usd: 25.usd, .jpy: 1000.jpy])
        let result = a + b
        #expect(result.amounts[.usd] == 125.usd)
        #expect(result.amounts[.eur] == 50.eur)
        #expect(result.amounts[.jpy] == 1000.jpy)
    }

    @Test func addMixed_EmptyAndNonEmpty_ReturnsNonEmpty() {
        let a = MixedAmount.zero
        let b = MixedAmount([.usd: 100.usd])
        #expect((a + b) == b)
    }

    @Test func addMixed_Commutative() {
        let a = MixedAmount([.usd: 100.usd, .eur: 50.eur])
        let b = MixedAmount([.usd: 25.usd, .jpy: 1000.jpy])
        #expect((a + b) == (b + a))
    }

    // MARK: - MixedAmount - MixedAmount

    @Test func subtractMixed_SameCurrency_Reduces() {
        let a = MixedAmount([.usd: 100.usd])
        let b = MixedAmount([.usd: 40.usd])
        #expect((a - b).amounts[.usd] == 60.usd)
    }

    @Test func subtractMixed_OverlappingCurrencies_ReducesEach() {
        let a = MixedAmount([.usd: 100.usd, .eur: 80.eur])
        let b = MixedAmount([.usd: 30.usd, .eur: 50.eur])
        let result = a - b
        #expect(result.amounts[.usd] == 70.usd)
        #expect(result.amounts[.eur] == 30.eur)
    }

    @Test func subtractMixed_CurrencyNotInLhs_GoesNegative() {
        let a = MixedAmount([.usd: 100.usd])
        let b = MixedAmount([.eur: 50.eur])
        let result = a - b
        #expect(result.amounts[.usd] == 100.usd)
        #expect(result.amounts[.eur] == (-50).eur)
    }

    // MARK: - MixedAmount * Decimal

    @Test func multiply_ByPositiveScalar_ScalesAll() {
        let mix = MixedAmount([.usd: 100.usd, .eur: 50.eur])
        let result = mix * Decimal(2)
        #expect(result.amounts[.usd] == 200.usd)
        #expect(result.amounts[.eur] == 100.eur)
    }

    @Test func multiply_ByZero_AllBecomesZero() {
        let mix = MixedAmount([.usd: 100.usd, .eur: 50.eur])
        let result = mix * Decimal(0)
        #expect(result.amounts[.usd] == 0.usd)
        #expect(result.amounts[.eur] == 0.eur)
    }

    @Test func multiply_ByFraction_Rounds() {
        let mix = MixedAmount([.usd: 100.usd])
        let result = mix * Decimal(string: "0.5")!
        #expect(result.amounts[.usd] == 50.usd)
    }

    @Test func multiply_Empty_RemainsEmpty() {
        let mix = MixedAmount.zero
        let result = mix * Decimal(100)
        #expect(result.amounts.isEmpty)
    }

    // MARK: - Negation (unary -)

    @Test func negate_FlipsAllSigns() {
        let mix = MixedAmount([.usd: 100.usd, .eur: (-50).eur])
        let result = -mix
        #expect(result.amounts[.usd] == (-100).usd)
        #expect(result.amounts[.eur] == 50.eur)
    }

    @Test func negate_Empty_RemainsEmpty() {
        #expect((-MixedAmount.zero).amounts.isEmpty)
    }

    @Test func negate_TwiceIsIdentity() {
        let mix = MixedAmount([.usd: 100.usd, .jpy: 500.jpy])
        #expect((-(-mix)) == mix)
    }

    // MARK: - exchange

    @Test func exchange_SingleCurrencySameAsDestination_ReturnsSame() {
        let mix = MixedAmount([.usd: 100.usd])
        let (result, missing) = mix.exchange(for: .usd, using: [:])
        #expect(result == 100.usd)
        #expect(missing.isEmpty)
    }

    @Test func exchange_SingleCurrency_AppliesRate() {
        // 10000 minor units = $100.00; at rate 0.9 → €90.00 = 9000 minor units
        let mix = MixedAmount([.usd: Amount(amountMinor: 10000, currency: .usd)])
        let rates: [CommodityPair: Decimal] = [CommodityPair(.usd, .eur): Decimal(string: "0.9")!]
        let (result, missing) = mix.exchange(for: .eur, using: rates)
        #expect(result == Amount(amountMinor: 9000, currency: .eur))
        #expect(missing.isEmpty)
    }

    @Test func exchange_MultiCurrency_SumsConvertedAmounts() {
        // $100.00 * 0.9 = €90.00 (9000 cents), ¥1000 * 0.006 = €6.00 (600 cents) → €96.00
        let mix = MixedAmount([.usd: Amount(amountMinor: 10000, currency: .usd),
                               .jpy: Amount(amountMinor: 1000, currency: .jpy)])
        let rates: [CommodityPair: Decimal] = [
            CommodityPair(.usd, .eur): Decimal(string: "0.9")!,
            CommodityPair(.jpy, .eur): Decimal(string: "0.006")!
        ]
        let (result, missing) = mix.exchange(for: .eur, using: rates)
        #expect(result == Amount(amountMinor: 9600, currency: .eur))
        #expect(missing.isEmpty)
    }

    @Test func exchange_EmptyMixed_ReturnsZero() {
        let (result, missing) = MixedAmount.zero.exchange(for: .usd, using: [:])
        #expect(result == 0.usd)
        #expect(missing.isEmpty)
    }

    @Test func exchange_MissingRate_ReturnsPartialResultAndMissingPairs() {
        let mix = MixedAmount([.usd: Amount(amountMinor: 10000, currency: .usd)])
        let (result, missing) = mix.exchange(for: .eur, using: [:])
        #expect(result == 0.eur)
        #expect(missing == [CommodityPair(.usd, .eur)])
    }

    @Test func exchange_PartialRates_AccumulatesAvailableAndReportsMissing() {
        let mix = MixedAmount([.usd: Amount(amountMinor: 10000, currency: .usd),
                               .jpy: Amount(amountMinor: 1000, currency: .jpy)])
        let rates: [CommodityPair: Decimal] = [CommodityPair(.usd, .eur): Decimal(string: "0.9")!]
        let (result, missing) = mix.exchange(for: .eur, using: rates)
        #expect(result == Amount(amountMinor: 9000, currency: .eur))
        #expect(missing == [CommodityPair(.jpy, .eur)])
    }
}

// MARK: - Convenience literals matching existing test style

private extension Int {
    var usd: Amount { Amount(amountMinor: self, currency: .usd) }
    var eur: Amount { Amount(amountMinor: self, currency: .eur) }
    var jpy: Amount { Amount(amountMinor: self, currency: .jpy) }
}
