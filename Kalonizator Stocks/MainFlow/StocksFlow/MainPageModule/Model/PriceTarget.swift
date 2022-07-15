import Foundation

public struct PriceTarget: Codable {
  public var lastUpdated: String
  public var symbol: String
  public var targetHigh: Float
  public var targetLow: Float
  public var targetMean: Float
  public var targetMedian: Float
}
