//
//  CryptoForList.swift
//  Evaluation3
//
//  Created by Student01 on 15/09/2022.
//

import Foundation


import Foundation


struct DataCrypto: Codable{
    var coins: [Crypto]
}

struct Crypto: Codable {
    var id: String
    var icon: String
}


