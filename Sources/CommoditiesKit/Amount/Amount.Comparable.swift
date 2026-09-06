import Foundation

extension Amount: Comparable {
    public static func + (lhs: Amount, rhs: Amount) -> Amount {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")
        return Amount(amountMinor: lhs.amountMinor + rhs.amountMinor, currency: lhs.currency)
    }

    public static func - (lhs: Amount, rhs: Amount) -> Amount {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")

        return Amount(amountMinor: lhs.amountMinor - rhs.amountMinor, currency: lhs.currency)
    }

    public static func / (lhs: Amount, rhs: Amount) -> Decimal {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")

        return lhs.value / rhs.value
    }

    public static func * (lhs: Amount, rhs: Decimal) -> Amount {
        return lhs.exchange(for: lhs.currency, at: rhs)
    }

    public static func == (lhs: Amount, rhs: Amount) -> Bool {
        return lhs.currency == rhs.currency && lhs.value == rhs.value
    }

    public static func != (lhs: Amount, rhs: Amount) -> Bool {
        return !(lhs == rhs)
    }

    public static func < (lhs: Amount, rhs: Amount) -> Bool {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")
        return lhs.amountMinor < rhs.amountMinor
    }

    public static func <= (lhs: Amount, rhs: Amount) -> Bool {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")

        return lhs.amountMinor <= rhs.amountMinor
    }

    public static func >= (lhs: Amount, rhs: Amount) -> Bool {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")

        return lhs.amountMinor >= rhs.amountMinor
    }

    public static func > (lhs: Amount, rhs: Amount) -> Bool {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")

        return lhs.amountMinor > rhs.amountMinor
    }

    public static func < (lhs: Amount, rhs: Int) -> Bool {
        precondition(rhs == 0, "Can only compare with zero")
        return lhs.amountMinor < rhs
    }

    public static func <= (lhs: Amount, rhs: Int) -> Bool {
        precondition(rhs == 0, "Can only compare with zero")
        return lhs.amountMinor <= rhs
    }

    public static func >= (lhs: Amount, rhs: Int) -> Bool {
        precondition(rhs == 0, "Can only compare with zero")
        return lhs.amountMinor >= rhs
    }

    public static func > (lhs: Amount, rhs: Int) -> Bool {
        precondition(rhs == 0, "Can only compare with zero")
        return lhs.amountMinor > rhs
    }

    public var isZero: Bool {
        amountMinor == 0
    }

    public static prefix func - (money: Amount) -> Amount {
        Amount(amountMinor: -money.amountMinor, currency: money.currency)
    }

}
