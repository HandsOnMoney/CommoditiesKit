import Foundation

public func abs(_ amount: Amount) -> Amount {
    Amount(amountMinor: abs(amount.amountMinor), currency: amount.currency)
}
