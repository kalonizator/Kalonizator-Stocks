import Foundation
import Alamofire

public protocol ApiTarget {

  var version: ApiVersion { get }
  var servicePath: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: Any]? { get }
  var headers: HTTPHeaders? { get }
  var stubData: Any { get }
  var encoding: ParameterEncoding { get }

  func createRequest(baseUrl: URL, manager: Session, interceptor: RequestInterceptor) -> Alamofire.DataRequest
}

public protocol UploadTarget: ApiTarget {
  var multipart: MultipartFormData { get }
}

public enum ApiVersion {

  case number(Int)
  case custom(String)

  public var stringValue: String {
    switch self {
    case .number(let value):
      return "v\(value)"
    case .custom(let value):
      return value
    }
  }
}

public extension ApiTarget {

  var defaultService: String {
    return "api"
  }

  var defaultHeaders: HTTPHeaders {
    var headers = HTTPHeaders()
    headers["Content-Type"] = "application/json"
    headers["Accept"] = "application/json"
    return headers
  }

  var headers: HTTPHeaders? {
    return defaultHeaders
  }

  var defaultEncoding: ParameterEncoding {
    switch method {
    case .get:
      return URLEncoding.queryString
    case .put:
      return URLEncoding.queryString
    case .post:
      return JSONEncoding.default
    case .delete:
      return JSONEncoding.default
    case .patch:
      return JSONEncoding.default
    }
  }

  var encoding: ParameterEncoding {
    return defaultEncoding
  }

  var stubData: Any { [:] }
}

public enum ApiResponseError: LocalizedError {

  case badServerResponse

  public var errorDescription: String? {
    switch self {
    case .badServerResponse:
      return "Something went wrong with the request"
    }
  }
}
