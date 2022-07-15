import Foundation

public struct FDACalendarEvent: Codable {
  public var fromDate: String
  public var toDate: String
  public var eventDescription: String
  public var url: String
}
