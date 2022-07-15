import Foundation
import Alamofire
import RxSwift

public protocol StocksRequestRetrier: RequestRetrier {
  typealias RetryCompletion = (RetryResult) -> Void

  func shouldRetryRequestFailed(with error: Error, completion: @escaping RetryCompletion)
}

final class StocksRequestRetrierImpl: StocksRequestRetrier {

  private var lock = NSLock()
  private var requestsToRetry = [RetryCompletion]()

  private let disposeBag = DisposeBag()

  func shouldRetryRequestFailed(with error: Error, completion: @escaping RetryCompletion) {

    lock.lock()

    defer {
      lock.unlock()
    }

    guard
      let underlyingError = error.asAFError?.underlyingError
    else {
      completion(.doNotRetry)
      return
    }

    requestsToRetry.append(completion)

    #if DEBUG
    logger.info("Refreshing token...")
    #endif

    completion(.doNotRetry)
  }

  // MARK: RequestRetrier
  public func retry(
    _ request: Request,
    for session: Session,
    dueTo error: Error,
    completion: @escaping (RetryResult) -> Void
  ) {
    shouldRetryRequestFailed(with: error, completion: completion)
  }
}
