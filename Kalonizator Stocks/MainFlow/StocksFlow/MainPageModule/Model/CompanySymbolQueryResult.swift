import Foundation

public struct CompanySymbolQueryResult: Codable {
  public var count: Int
  public var result: [CompanySymbol]
}
