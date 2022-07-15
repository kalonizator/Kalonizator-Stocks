public protocol OptionalCodingWrapper {
  associatedtype WrappedType: ExpressibleByNilLiteral

  init(wrappedValue: WrappedType)
}

public extension KeyedDecodingContainer {

  func decode<T>(
    _ type: T.Type,
    forKey key: KeyedDecodingContainer<K>.Key
  ) throws -> T where T: Decodable & OptionalCodingWrapper {
    try decodeIfPresent(T.self, forKey: key) ?? T(wrappedValue: nil)
  }
}
