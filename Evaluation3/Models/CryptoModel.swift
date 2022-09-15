//
//  CryptoModel.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import Foundation

struct Data: Codable{
    var data: [Coin]
}

struct Coin: Codable{
    var id: String
    var rank: String
    var name: String
    var symbol: String
    var supply: String
    var maxSupply: String?
    var marketCapUsd: String
    var volumeUsd24Hr: String
    var priceUsd: String
    var changePercent24Hr: String
    var vwap24Hr: String?
    var explorer: String?
    enum CodingKeys: String, CodingKey {
        case id
        case rank
        case name
        case symbol
        case supply
        case maxSupply
        case marketCapUsd
        case volumeUsd24Hr
        case priceUsd
        case changePercent24Hr
        case vwap24Hr
        case explorer
    }
}
