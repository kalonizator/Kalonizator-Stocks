import Foundation

// MARK: - StockDetails
struct StockDetails: Codable {
  let country, currency, exchange, ipo: String?
  let name, phone: String?
  let shareOutstanding: Double?
  let ticker: String?
  let weburl: String?
  let logo: String?
  let finnhubIndustry: String?

  var isEmpty: Bool {
    return name == nil && finnhubIndustry == nil && ticker == nil
  }
}
