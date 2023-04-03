//
//  SearchResponse.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/04.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}
// MARK: - Result
struct SearchResult: Codable {
    let description, displaySymbol, symbol, type: String
}
