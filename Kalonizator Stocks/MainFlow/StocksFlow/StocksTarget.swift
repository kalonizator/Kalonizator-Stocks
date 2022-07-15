import Foundation

enum StocksTarget: ApiTarget {

  case companyDetails(symbol: String, token: String)
  case search(text: String, token: String)

  var version: ApiVersion {
    .number(1)
  }

  var servicePath: String {
    return "\(defaultService)"
  }

  var path: String {
    switch self {
    case .search:
      return "search"
    case .companyDetails:
      return "stock/profile2"
    }
  }

  var method: HTTPMethod {
    return .get
  }

  var parameters: [String: Any]? {
    switch self {
    case .search(let text, let token):
      return [
        "token": token,
        "q": text
      ]
    case .companyDetails(let symbol, let token):
      return [
        "token": token,
        "symbol": symbol
      ]
    }
  }
}
