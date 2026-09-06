import Foundation

extension MixedAmount: Equatable {
    public static func + (lhs: MixedAmount, rhs: Amount) -> MixedAmount {
        var amounts = lhs.amounts
        amounts[rhs.currency] = amounts[rhs.currency, default: rhs.currency.zero] + rhs
        return MixedAmount(amounts)
    }

    public static func + (lhs: MixedAmount, rhs: MixedAmount) -> MixedAmount {
        var amounts = lhs.amounts
        for (commodity, amount) in rhs.amounts {
            amounts[commodity] = amounts[commodity, default: commodity.zero] + amount
        }
        return MixedAmount(amounts)
    }

    public static func - (lhs: MixedAmount, rhs: Amount) -> MixedAmount {
        var amounts = lhs.amounts
        amounts[rhs.currency] = amounts[rhs.currency, default: rhs.currency.zero] - rhs
        return MixedAmount(amounts)
    }

    public static func - (lhs: MixedAmount, rhs: MixedAmount) -> MixedAmount {
        var amounts = lhs.amounts
        for (commodity, amount) in rhs.amounts {
            amounts[commodity] = amounts[commodity, default: commodity.zero] - amount
        }
        return MixedAmount(amounts)
    }

    public static func * (lhs: MixedAmount, rhs: Decimal) -> MixedAmount {
        MixedAmount(lhs.amounts.mapValues { $0 * rhs })
    }

    public static func == (lhs: MixedAmount, rhs: MixedAmount) -> Bool {
        for (lhsCommodity, lhsAmount) in lhs.amounts {
            if lhsAmount != rhs.amounts[lhsCommodity, default: lhsCommodity.zero] {
                return false
            }
        }

        for (rhsCommodity, rhsAmount) in rhs.amounts {
            if rhsAmount != lhs.amounts[rhsCommodity, default: rhsCommodity.zero] {
                return false
            }
        }

        return true
    }

    public static prefix func - (mix: MixedAmount) -> MixedAmount {
        MixedAmount(mix.amounts.mapValues { -$0 })
    }
}
