import Foundation

public struct MixedAmount: Sendable {
    public let amounts: [Commodity: Amount]

    public init() {
        self.amounts = [:]
    }

    public init(_ amount: Amount?) {
        if let amount {
            self.amounts = [amount.currency: amount]
        } else {
            self.amounts = [:]
        }
    }

    public init(_ amounts: [Amount]) {
        var dict: [Commodity: Amount] = [:]
        for amount in amounts {
            dict[amount.currency] = dict[amount.currency, default: amount.currency.zero] + amount
        }
        self.amounts = dict
    }

    public init(_ amounts: [Commodity: Amount]) {
        assert(amounts.allSatisfy { $0.key == $0.value.currency }, "MixedAmount: dict key must match Amount.currency")
        self.amounts = amounts
    }

    public static let zero = MixedAmount()
}
