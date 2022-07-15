import Foundation

final class ConfigServiceImpl: ConfigService {

  lazy var applicationApiToken: String = {
    return "cb277miad3i9jtl2vic0"
  }()

  var apiUrl: URL {
    guard let url = URL(string: Constants.prodUrl) else {
      fatalError("Api URL not correct")
    }
    return url
  }

  var socketSdkUrl: URL {
    guard let url = URL(string: "\(Constants.socketUrl)?token=\(Constants.apiKey)") else {
      fatalError("Api URL not correct")
    }
    return url
  }
}

extension ConfigServiceImpl {
  enum Constants {
    static let prodUrl = "https://finnhub.io"
    static let socketUrl = "wss://ws.finnhub.io"
    static let apiKey = "cb277miad3i9jtl2vic0"
  }
}
