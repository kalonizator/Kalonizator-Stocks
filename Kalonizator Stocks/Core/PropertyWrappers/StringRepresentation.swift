@propertyWrapper
public struct StringRepresentation<T: StringInitable>: Decodable {

  public var wrappedValue: T

  public init(wrappedValue: T) {
    self.wrappedValue = wrappedValue
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    guard let value = T.init(string: string) else {
      throw DecodingError.dataCorruptedError(
        in: container,
        debugDescription: "Can't convert \(string) value to \(T.self)"
      )
    }
    self.wrappedValue = value
  }
}

extension StringRepresentation: OptionalCodingWrapper where T: ExpressibleByNilLiteral {}
