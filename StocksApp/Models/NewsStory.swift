//
//  NewsStory.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/05.
//

import Foundation

struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let id: Int
    let image: String
    let related, source, summary: String
    let url: String
}
