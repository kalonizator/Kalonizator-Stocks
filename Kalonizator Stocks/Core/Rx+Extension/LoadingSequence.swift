public protocol LoadingSequenceConvertible {

  associatedtype Element

  var result: Result<Element, Error>? { get }
  var isLoading: Bool { get }
}

public struct LoadingSequence<Element>: LoadingSequenceConvertible {

  public let result: Result<Element, Error>?
  public let isLoading: Bool

  init(isLoading: Bool) {
    self.result = nil
    self.isLoading = isLoading
  }

  init(result: Result<Element, Error>) {
    self.result = result
    self.isLoading = false
  }

  func convertElement<R>(_ transform: (Element) -> R) -> LoadingSequence<R> {
    guard let result = result else {
      return LoadingSequence<R>(isLoading: isLoading)
    }
    switch result {
    case .failure(let error):
      return LoadingSequence<R>(result: .failure(error))
    case .success(let element):
      return LoadingSequence<R>(result: .success(transform(element)))
    }
  }
}
