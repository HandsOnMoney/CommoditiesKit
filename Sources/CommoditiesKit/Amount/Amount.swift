import Foundation

public struct Amount: Equatable, Hashable, Sendable {
    public let amountMinor: Int
    public let currency: Commodity

    public init(amountMinor: Int, currency: Commodity) {
        self.amountMinor = amountMinor
        self.currency = currency
    }

    public init(amount: Decimal, currency: Commodity) {
        var decimalResult = amount * pow(Decimal(string: "10")!, currency.digits)
        var rounded: Decimal = 0
        NSDecimalRound(&rounded, &decimalResult, 0, .bankers)
        self.amountMinor = NSDecimalNumber(decimal: rounded).intValue
        self.currency = currency
    }

    public var value: Decimal {
        self.amountMinor.minorUnitsWith(digits: currency.digits)
    }

    public var amountDouble: Double {
        let divisor = pow(10.0, Double(currency.digits))
        let value = Double(amountMinor) / divisor
        return (value * divisor).rounded(.toNearestOrEven) / divisor
    }
}

extension Int {
    public func minorUnitsWith(digits: Int) -> Decimal {
        var decimalResult: Decimal = Decimal(self) / pow(Decimal(string: "10.0")!, digits)
        var rounded: Decimal = 0
        NSDecimalRound(&rounded, &decimalResult, digits, .bankers)
        return rounded
    }
}

extension Decimal {
    public var precision: Int {
        max(0, -exponent)
    }

    public var minorUnits: Int {
        NSDecimalNumber(decimal: self * pow(10 as Decimal, precision)).intValue
    }
}
