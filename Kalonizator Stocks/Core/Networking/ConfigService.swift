import Foundation

public typealias ApplicationId = Int64
public typealias ApplicationSecret = String

public protocol ConfigService {

  var apiUrl: URL { get }
  var socketSdkUrl: URL { get }
  var applicationApiToken: String { get }
}
