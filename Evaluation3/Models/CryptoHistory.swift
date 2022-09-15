//
//  CryptoHistory.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import Foundation

struct DataHistory: Codable{
    var data: [CryptoHistory]
}

struct CryptoHistory: Codable {
    var priceUsd: String
    var time: Int
    var date: String
}
