import Foundation

public struct Commodity: Equatable, Hashable, Encodable, Decodable, Identifiable, Sendable {
    public var id: String {
        if let namespace = namespace {
            "\(namespace):\(mnemonic)"
        } else {
            mnemonic
        }
    }

    public let mnemonic: String
    public let digits: Int
    public let namespace: String?
    public let securityIdentifier: String? // note: securityIdentifier is not a part of equals check since it's an optional field

    public init(mnemonic: String, digits: Int, namespace: String? = "CURRENCY", securityIdentifier: String? = nil) {
        self.mnemonic = mnemonic
        self.digits = digits
        self.namespace = namespace
        self.securityIdentifier = securityIdentifier
    }

    public static func == (lhs: Commodity, rhs: Commodity) -> Bool {
        lhs.mnemonic == rhs.mnemonic && lhs.namespace == rhs.namespace && lhs.digits == rhs.digits
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(mnemonic)
        hasher.combine(namespace)
        hasher.combine(digits)
    }
}

extension Commodity {
    public var zero: Amount {
        Amount(amountMinor: 0, currency: self)
    }
}
