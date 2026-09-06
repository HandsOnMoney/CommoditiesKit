import Foundation

extension Amount {
    public func exchange(for destinationCurrency: Commodity, using rates: [CommodityPair: Decimal]) throws(MissingPriceError) -> Amount {
        guard self.currency.mnemonic != destinationCurrency.mnemonic else {
            return self
        }

        let pair = CommodityPair(self.currency, destinationCurrency)
        guard let rate = rates[pair] else {
            throw MissingPriceError(pair: pair)
        }

        return exchange(for: destinationCurrency, at: rate)
    }

    public func exchange(for destinationCurrency: Commodity, at rate: Decimal) -> Amount {
        var decimalResult: Decimal = value*rate
        var rounded: Decimal = 0
        NSDecimalRound(&rounded, &decimalResult, destinationCurrency.digits, .bankers)
        return Amount(amount: rounded, currency: destinationCurrency)
    }
}
