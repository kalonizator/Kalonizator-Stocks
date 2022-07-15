import RxAlamofire
import RxSwift
import Alamofire
import Foundation

public struct ApiRequest: ApiRequestable {

  private let request: Alamofire.DataRequest

  public init(url: URL, target: ApiTarget, manager: Session, interceptor: RequestInterceptor) {
    self.request = target.createRequest(
      baseUrl: url,
      manager: manager,
      interceptor: interceptor
    ).response {
      #if DEBUG
      logger.response(
        code: $0.response?.statusCode,
        path: $0.response?.url?.absoluteString,
        data: $0.data,
        logLevel: Constants.networkLogLevel
      )
      #endif
    }
  }

  public func cancel() {
    request.cancel()
  }

  public func run() -> Observable<Data> {

    request.resume()

    #if DEBUG
    request.cURLDescription { [weak request] _ in
      guard let request = request else { return }
      logger.request(
        method: request.request?.httpMethod,
        path: request.request?.url?.absoluteString,
        bodyData: request.request?.httpBody,
        logLevel: Constants.networkLogLevel
      )
    }
    #endif

    var codes = DataResponseSerializer.defaultEmptyResponseCodes
    codes.insert(200)
    let serializer = DataResponseSerializer(emptyResponseCodes: codes)

    return request
      .validate { _, response, data in

        if 200..<300 ~= response.statusCode { return .success(()) }

        guard let data = data else {
          return .failure(ApiResponseError.badServerResponse)
        }

        guard let apiError = try? JSONDecoder().decode(ApiError.self, from: data) else {
          return .failure(ApiResponseError.badServerResponse)
        }

        guard case let .exception(exception) = apiError else { return .failure(apiError) }

        var errorDescription = exception.error.message
        if response.statusCode >= 500 {
          errorDescription = ApiResponseError.badServerResponse.localizedDescription
        }

        return .failure(
          NSError(
            domain: apiErrorDomain,
            code: exception.code,
            userInfo: [NSLocalizedDescriptionKey: errorDescription]
          )
        )
      }
      .rx.responseResult(responseSerializer: serializer)
      .catchError { error in
        throw error.asAFError?.underlyingError ?? error
      }
      .do(onError: { error in
        #if DEBUG
        logger.error("\(error)", errorType: .responseError)
        #endif
      })
      .map { _, data in data }
  }
}

// MARK: Constants
private extension ApiRequest {

  enum Constants {
    #if DEBUG
    static let networkLogLevel: StocksLogger.NetworkLogLevel = .verbose
    #endif
  }
}

extension HTTPMethod {

  var alamofireMethod: Alamofire.HTTPMethod {
    switch self {
    case .get:
      return .get
    case .post:
      return .post
    case .put:
      return .put
    case .delete:
      return .delete
    case .patch:
      return .patch
    }
  }
}

public extension ApiTarget {

  fileprivate func appendComponents(to baseUrl: URL) -> URL {
    baseUrl
      .appendingPathComponent(servicePath)
      .appendingPathComponent(version.stringValue)
      .appendingPathComponent(path)
  }

  func createRequest(
    baseUrl: URL,
    manager: Session,
    interceptor: RequestInterceptor
  ) -> Alamofire.DataRequest {
    manager.request(
      appendComponents(to: baseUrl),
      method: method.alamofireMethod,
      parameters: parameters,
      encoding: encoding,
      headers: headers,
      interceptor: interceptor
    )
  }
}

public extension UploadTarget {

  func createRequest(baseUrl: URL, manager: Session, interceptor: RequestInterceptor) -> Alamofire.DataRequest {
    manager.upload(
      multipartFormData: multipart,
      to: appendComponents(to: baseUrl),
      method: method.alamofireMethod,
      headers: headers,
      interceptor: interceptor
    )
  }
}
