import Foundation

public struct AggregateIndicators: Codable {
  public var technicalAnalysis: TechnicalAnalysis
  public var trend: Trend
  
  /*
   
   {
   "technicalAnalysis":{
   "count":{
   "buy":7,
   "neutral":8,
   "sell":2
   },
   "signal":"buy"
   },
   "trend":{
   "adx":20.172131665096146,
   "trending":false
   }
   }
   
   */
}

public struct TechnicalAnalysis: Codable {
  public var count: TechnicalAnalysisCount
  public var signal: String
}

public struct TechnicalAnalysisCount: Codable {
  public var buy: Int
  public var neutral: Int
  public var sell: Int
}

public struct Trend: Codable {
  public var adx: Float
  public var trending: Bool
}
