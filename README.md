# CommoditiesKit

A Swift library for working with monetary amounts and commodity-based arithmetic. Amounts are stored as integer minor units (cents, pence, etc.) to avoid floating-point rounding errors.

> **Note:** This README was generated with an LLM. The library code is hand-written; tests were generated with LLM assistance and are marked `// llm-generated` at the top of each file.

---

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/vitaliipianykh/CommoditiesKit", from: "1.0.0")
]
```

---

## Core concepts

| Type | Role |
|---|---|
| `Commodity` | A currency or commodity (mnemonic, decimal digits, optional namespace) |
| `Amount` | A single-commodity value stored as integer minor units |
| `MixedAmount` | A basket of `Amount` values across different commodities |
| `CommodityPair` | A directed pair of commodities used as an exchange-rate key |

---

## Usage

### Commodity

```swift
// From the built-in well-known currency table (throws for unknown codes)
let usd = try Commodity(wellKnownCode: "USD")  // digits: 2
let jpy = try Commodity(wellKnownCode: "JPY")  // digits: 0

// Directly — useful for custom or non-ISO commodities
let btc = Commodity(mnemonic: "BTC", digits: 8, namespace: "CRYPTO")

// Convenience statics (intended for tests and previews)
let eur = Commodity.eur

// Enumerate all well-known currencies, sorted by mnemonic
let all = Commodity.wellKnownCurrencies

usd.mnemonic  // "USD"
usd.digits    // 2
usd.icon      // "🇺🇸"
```

### Amount

```swift
// From minor units (cents, pence, …)
let price = Amount(amountMinor: 1099, currency: .usd)  // $10.99

// From a Decimal major value — rounded with banker's rounding
let fee = Amount(amount: 2.50, currency: .eur)          // €2.50

// Int literal helpers
let tax   = 45.usdCents    // $0.45
let total = 1099.usdMinor  // $10.99
let yen   = 500.jpy        // ¥500

// Generic helper — looks up digits from the well-known table
let amount = try 1099.of("USD")

// Zero for a commodity
let zero = Commodity.usd.zero
```

### Arithmetic

```swift
let a = 1000.usdCents   // $10.00
let b =  250.usdCents   //  $2.50

let sum        = a + b   // $12.50
let difference = a - b   //  $7.50
let scaled     = a * 1.5 // $15.00  (Decimal multiplier)
let ratio      = a / b   // 4       (returns Decimal)
let negated    = -a      // -$10.00
let absolute   = abs(-a) //  $10.00

a > b     // true
a.isZero  // false
```

`+`, `-`, `/`, and comparison operators trap on currency mismatch — use `MixedAmount` or exchange first.

### Exchange

```swift
let rates: [CommodityPair: Decimal] = [
    CommodityPair(.usd, .eur): 0.92
]

// Throws MissingPriceError if the pair is absent
let inEur = try 1000.usdCents.exchange(for: .eur, using: rates)  // €9.20

// Or supply the rate directly
let inEur2 = 1000.usdCents.exchange(for: .eur, at: 0.92)
```

### MixedAmount

```swift
// Build a basket
var basket = MixedAmount.zero
basket = basket + 1000.usdCents  // $10.00 USD
basket = basket + 500.eurCents   //  €5.00 EUR
basket = basket + 200.usdCents   // $12.00 USD, €5.00 EUR

// Arithmetic between baskets
let a      = MixedAmount([1000.usdCents, 300.eurCents])
let b      = MixedAmount([400.usdCents])
let result = a - b   // $6.00 USD, €3.00 EUR

// Scale all legs
let doubled = basket * 2

// Convert the whole basket to a single currency.
// Returns the total and a list of pairs for which rates were missing.
let rates: [CommodityPair: Decimal] = [
    CommodityPair(.usd, .eur): 0.92
]
let (total, missingRates) = basket.exchange(for: .eur, using: rates)
```

---

## Design notes

- **Integer storage.** `Amount.amountMinor` is always an `Int`. Decimal conversion uses `NSDecimalRound` with `.bankers` (round-half-to-even) rounding, consistent with IEEE 754.
- **Same-currency enforcement.** Arithmetic operators trap via `precondition` on currency mismatch. Exchange before combining different currencies.
- **`Commodity` equality** is based on `mnemonic + namespace + digits`. `securityIdentifier` is intentionally excluded so the same currency from different data sources compares equal.
- **`MixedAmount.exchange`** returns `(Amount, [CommodityPair])` — the converted total plus any pairs for which rates were missing — so callers decide how to handle incomplete rate sets rather than throwing.
