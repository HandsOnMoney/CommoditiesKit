import Foundation

extension MixedAmount {
    public func exchange(for destinationCurrency: Commodity, using rates: [CommodityPair: Decimal]) -> (Amount, [CommodityPair]) {
        var result = destinationCurrency.zero
        var missingRates: [CommodityPair] = []

        for amount in self.amounts.values {
            do {
                result = result + (try amount.exchange(for: destinationCurrency, using: rates))
            } catch let error {
                missingRates.append(error.pair)
            }
        }

        return (result, missingRates)
    }
}
