import Foundation

extension Decimal {
    public func of(_ currencyCode: String) throws -> Amount {
        let currency = try Commodity(wellKnownCode: currencyCode)
        return Amount(amount: self, currency: currency)
    }

    public func of(_ currencyCode: String, digits: Int) -> Amount {
        let currency = Commodity(mnemonic: currencyCode, digits: digits)
        return Amount(amount: self, currency: currency)
    }

    public func of(_ currency: Commodity) -> Amount {
        return Amount(amount: self, currency: currency)
    }

    public var usd: Amount { Amount(amount: self, currency: cu("USD", digits: 2)) }
    public var eur: Amount { Amount(amount: self, currency: cu("EUR", digits: 2)) }
    public var jpy: Amount { Amount(amount: self, currency: cu("JPY", digits: 0)) }
    public var gbp: Amount { Amount(amount: self, currency: cu("GBP", digits: 2)) }
    public var cad: Amount { Amount(amount: self, currency: cu("CAD", digits: 2)) }
    public var aud: Amount { Amount(amount: self, currency: cu("AUD", digits: 2)) }
    public var chf: Amount { Amount(amount: self, currency: cu("CHF", digits: 2)) }
    public var cny: Amount { Amount(amount: self, currency: cu("CNY", digits: 2)) }
    public var hkd: Amount { Amount(amount: self, currency: cu("HKD", digits: 2)) }
    public var sek: Amount { Amount(amount: self, currency: cu("SEK", digits: 2)) }

    private func cu(_ code: String, digits: Int) -> Commodity { Commodity(mnemonic: code, digits: digits) }
}
