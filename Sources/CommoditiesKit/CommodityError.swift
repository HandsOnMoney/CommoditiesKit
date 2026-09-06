import Foundation

public enum CommodityError: LocalizedError, Equatable {
    case unknownCurrencyCode(code: String)

    public var errorDescription: String? {
        switch self {
        case .unknownCurrencyCode(code: let code):
            "Currency code '\(code)' is unknown"
        }
    }
}
