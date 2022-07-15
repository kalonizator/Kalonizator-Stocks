import Foundation

public enum StocksListServiceError: Error {
  case networkFailure(Error)
  case unknownFailure
  case invalidData
}

public enum StocksListServiceSuccess {
  case trades(LiveTrades)
  case news(LiveNews)
  case ping(LivePing)
  case empty
}

protocol StocksListService {
  func parseLiveText(_ text: String) -> Result<StocksListServiceSuccess, StocksListServiceError>
  func startConnection()
  func stopConnection()
  func subscribe(symbol: String)
  func subscribe(symbols: [String])
  func receiveMessage(completion: @escaping (Result<StocksListServiceSuccess, StocksListServiceError>) -> Void)
}

public class StocksListServiceImpl: StocksListService {

  private let socketService: SocketService

  init(socketService: SocketService) {
    self.socketService = socketService
    startConnection()
    setupObservers()
  }

  private func setupObservers() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(startConnection),
      name: Notification.Name.applicationBecomeActive,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(stopConnection),
      name: Notification.Name.applicationInBackground,
      object: nil
    )
  }

  @objc func startConnection() {
    socketService.startConnection()
  }

  @objc func stopConnection() {
    socketService.stopConnection()
  }

  func parseLiveText(_ text: String) -> Result<StocksListServiceSuccess, StocksListServiceError> {
    guard let json = text.data(using: .utf8) else {
      return (.failure(.invalidData))
    }
    let decoder = JSONDecoder()
    if let liveTrades = try? decoder.decode(LiveTrades.self, from: json) {
      return (.success(.trades(liveTrades)))
    } else if let marketNews = try? decoder.decode(LiveNews.self, from: json) {
      return (.success(.news(marketNews)))
    } else if let ping = try? decoder.decode(LivePing.self, from: json) {
      return (.success(.ping(ping)))
    } else {
      return (.failure(.invalidData))
    }
  }

  public func subscribe(symbol: String) {
    let messageString = "{\"type\":\"subscribe\",\"symbol\":\"\(symbol)\"}"
    socketService.sendMessage(string: messageString)
  }

  public func subscribe(symbols: [String]) {
    for symbol in symbols {
      subscribe(symbol: symbol)
    }
  }

  public func receiveMessage(completion: @escaping (Result<StocksListServiceSuccess, StocksListServiceError>) -> Void) {
    socketService.receiveMessage { [unowned self] result in
      switch result {
      case .connected:
        completion(.success(.empty))
      case .disconnected:
        completion(.success(.empty))
      case let .text(text):
        completion(self.parseLiveText(text))
      case .binary:
        completion(.success(.empty))
      case let .error(error):
        if let unwrappedError = error {
          completion(.failure(.networkFailure(unwrappedError)))
        } else {
          completion(.failure(.unknownFailure))
        }

      case .cancelled:
        completion(.success(.empty))
      }
    }
  }
}
