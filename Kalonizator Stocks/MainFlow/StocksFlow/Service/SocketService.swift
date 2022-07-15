import Foundation

enum SocketEvent {
  case connected([String: String])
  case disconnected(String, UInt16)
  case text(String)
  case binary(Data)
  case error(Error?)
  case cancelled
}

protocol SocketService {
  func startConnection()
  func stopConnection()
  func sendMessage(string: String)
  func receiveMessage(completion: @escaping (SocketEvent) -> Void)
}

class SocketServiceImpl: SocketService {

  init(url: URL) {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    task = urlSession.webSocketTask(with: url)
    startConnection()
  }

  init(url: URL, headers: (String, String)) {
    let urlSession = URLSession(configuration: .default)
    var request = URLRequest(url: url)
    request.setValue(headers.0, forHTTPHeaderField: headers.1)
    task = urlSession.webSocketTask(with: request)
    startConnection()
  }

  var task: URLSessionWebSocketTask?

  func sendMessage(string: String) {
    let socketMessage = URLSessionWebSocketTask.Message.string(string)
    task?.send(socketMessage) { error in
      if let error = error {
        print(error)
      }
    }
  }

  func receiveMessage(completion: @escaping (SocketEvent) -> Void) {
    task?.receive { [weak self] result in
      switch result {
      case let .success(message):
        switch message {
        case let .string(string):
          completion(.text(string))
        case let .data(data):
          completion(.binary(data))
        @unknown default:
          completion(.error(nil))
        }
      case let .failure(error):
        completion(.error(error))
      }
      self?.receiveMessage(completion: completion)
    }
  }

  func stopConnection() {
    task?.cancel(with: .goingAway, reason: nil)
  }

  func startConnection() {
    task?.resume()
  }
}
