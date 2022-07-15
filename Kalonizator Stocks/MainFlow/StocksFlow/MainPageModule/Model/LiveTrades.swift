import Foundation

public struct LiveTrades: LiveResponse, Codable {
  public var data: [Trade]
  public var type: String
}
