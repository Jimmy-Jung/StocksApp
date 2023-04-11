//
//  MarketDataResponse.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/06.
//

import Foundation

struct MarketDataResponse: Codable {
    let close, high, low, open: [Double]
    let status: String
    let timestamps: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case open = "o"
        case low = "l"
        case close = "c"
        case high = "h"
        case status = "s"
        case timestamps = "t"
    }
    
    var candleSticks: [CandleStick] {
        var result = [CandleStick]()
        for index in 0..<open.count {
            result.append(
                .init(
                    date: Date(timeIntervalSince1970: timestamps[index]),
                    close: close[index],
                    high: high[index],
                    low: low[index],
                    open: open[index]
                )
            )
        }
        
        let sortedData = result.sorted { $0.date > $1.date }
        return sortedData
    }
}

struct CandleStick {
    let date: Date
    let close, high, low, open: Double
}
