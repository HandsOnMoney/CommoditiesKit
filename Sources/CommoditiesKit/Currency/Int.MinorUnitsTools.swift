import Foundation

extension Int {
    public func of(_ currencyCode: String) throws -> Amount {
        let currency = try Commodity(wellKnownCode: currencyCode)
        return Amount(amountMinor: self, currency: currency)
    }

    public func of(_ currencyCode: String, digits: Int) -> Amount {
        let currency = Commodity(mnemonic: currencyCode, digits: digits)
        return Amount(amountMinor: self, currency: currency)
    }

    public func of(_ currency: Commodity) -> Amount {
        return Amount(amountMinor: self, currency: currency)
    }

    // Common aliases
    public var usdCents: Amount { usdMinor }
    public var eurCents: Amount { eurMinor }
    public var pence: Amount { gbpMinor }
    public var cadCents: Amount { cadMinor }
    public var audCents: Amount { audMinor }
    public var rappen: Amount { chfMinor }
    public var fen: Amount { cnyMinor }
    public var hkdCents: Amount { hkdMinor }
    public var sekOre: Amount { sekMinor }

    public var usdMinor: Amount { Amount(amountMinor: self, currency: cu("USD", digits: 2)) }
    public var eurMinor: Amount { Amount(amountMinor: self, currency: cu("EUR", digits: 2)) }
    public var jpy: Amount { Amount(amountMinor: self, currency: cu("JPY", digits: 0)) }
    public var gbpMinor: Amount { Amount(amountMinor: self, currency: cu("GBP", digits: 2)) }
    public var cadMinor: Amount { Amount(amountMinor: self, currency: cu("CAD", digits: 2)) }
    public var audMinor: Amount { Amount(amountMinor: self, currency: cu("AUD", digits: 2)) }
    public var chfMinor: Amount { Amount(amountMinor: self, currency: cu("CHF", digits: 2)) }
    public var cnyMinor: Amount { Amount(amountMinor: self, currency: cu("CNY", digits: 2)) }
    public var hkdMinor: Amount { Amount(amountMinor: self, currency: cu("HKD", digits: 2)) }
    public var sekMinor: Amount { Amount(amountMinor: self, currency: cu("SEK", digits: 2)) }

    // Helper to construct Commodity without relying on the well-known dictionary at runtime
    private func cu(_ code: String, digits: Int) -> Commodity { Commodity(mnemonic: code, digits: digits) }
}
