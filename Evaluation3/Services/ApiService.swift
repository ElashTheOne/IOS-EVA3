//
//  ApiService.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import Foundation
import Alamofire

protocol ApiService {
    func fetchData(completion: @escaping (Result<Data, AFError>) -> Void)
    
    func fetchData2(completion: @escaping (_ result: Result<Data, Error>) -> Void)
    
    func fetchHistory(coin: Coin, completion: @escaping (_ result: Result<DataHistory, Error>) -> Void)
    
    func fetchCrypto(completion: @escaping (_ result: Result<DataCrypto, Error>) -> Void)
    
}
