import Foundation
import Alamofire

public struct StocksRequestAdapter: RequestAdapter {

  private let configService: ConfigService

  public init(configService: ConfigService) {
    self.configService = configService
  }

  public func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void
  ) {
    var resultRequest = urlRequest
    completion(.success(resultRequest))
  }
}
