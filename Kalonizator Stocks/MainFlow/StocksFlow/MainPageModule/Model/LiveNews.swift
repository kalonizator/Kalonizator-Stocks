import Foundation

public struct LiveNews: LiveResponse, Codable {
  public var data: [MarketNews]
  public var type: String
}
