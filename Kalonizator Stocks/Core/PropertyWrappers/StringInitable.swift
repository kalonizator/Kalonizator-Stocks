import Foundation

public protocol StringInitable {
  init?(string: String)
}

extension Optional: StringInitable where Wrapped: StringInitable {

  public init?(string: String) {
    self = Wrapped.init(string: string)
  }
}

extension Decimal: StringInitable {
  public init?(string: String) {
    self.init(string: string, locale: nil)
  }
}
