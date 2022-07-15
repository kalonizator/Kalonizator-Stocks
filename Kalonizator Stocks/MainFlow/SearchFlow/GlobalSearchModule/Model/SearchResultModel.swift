import Foundation

// MARK: - SearchResultModel
struct SearchResultModel: Codable {
  let result: [SearchResultElement]
}

// MARK: - Result
struct SearchResultElement: Codable {
  let symbol: String?
  let resultDescription: String?
  let type, displaySymbol: String?
}
