//
//  FinancialMetricsResponse.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/11.
//

import Foundation

// MARK: - FinancialMetricsResponse
struct FinancialMetricsResponse: Codable {
    let series: Series
    let metric: Metrics
    let metricType: String
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case series = "series"
        case metric = "metric"
        case metricType = "metricType"
        case symbol = "symbol"
    }
}

// MARK: - Metric
struct Metrics: Codable {
    let the10DayAverageTradingVolume: Double
    let the52WeekHigh: Double
    let the52WeekLow: Double
    let the52WeekLowDate: String
    let the52WeekPriceReturnDaily: Double
    let beta: Double

    enum CodingKeys: String, CodingKey {
        case the10DayAverageTradingVolume = "10DayAverageTradingVolume"
        case the52WeekHigh = "52WeekHigh"
        case the52WeekLow = "52WeekLow"
        case the52WeekLowDate = "52WeekLowDate"
        case the52WeekPriceReturnDaily = "52WeekPriceReturnDaily"
        case beta = "beta"
    }
}

// MARK: - Series
struct Series: Codable {
    let annual: Annual

    enum CodingKeys: String, CodingKey {
        case annual = "annual"
    }
}

// MARK: - Annual
struct Annual: Codable {
    let currentRatio: [CurrentRatio]
    let salesPerShare: [CurrentRatio]
    let netMargin: [CurrentRatio]

    enum CodingKeys: String, CodingKey {
        case currentRatio = "currentRatio"
        case salesPerShare = "salesPerShare"
        case netMargin = "netMargin"
    }
}

// MARK: - CurrentRatio
struct CurrentRatio: Codable {
    let period: String
    let v: Double

    enum CodingKeys: String, CodingKey {
        case period = "period"
        case v = "v"
    }
}
