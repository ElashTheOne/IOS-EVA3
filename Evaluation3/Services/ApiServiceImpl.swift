//
//  ApiServiceImpl.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import Foundation
import Alamofire
import Foundation
import Network

struct ApiServiceImpl: ApiService {
    
    
    private let monitor = NWPathMonitor()
    private let url = "https://api.coincap.io/v2/assets"
    private let urlCrypto = "https://api.coinstats.app/public/v1/coins?skip=0&limit=50&currency=EUR"

    func fetchCrypto(completion: @escaping (Result<DataCrypto, Error>) -> Void) {
        
        checkNetwork(
            success: {
                let apiURL = URL(string: urlCrypto)!
                AF.request(apiURL).response { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data else { return }

                        do {
                            let data = try JSONDecoder().decode(DataCrypto.self, from: data)
                            completion(.success(data))
                        } catch {
                            print(error)
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
            },
            failure: {
                print("No network")
            }
        )
        
    }
    
    func fetchHistory(coin: Coin, completion: @escaping (Result<DataHistory, Error>) -> Void) {
        
        let newUrl = url + "/" + coin.id + "/" + "history?interval=d1"
        //let params = ["history" : "interval=d1"]
        
        checkNetwork(
            success: {
                let apiURL = URL(string: newUrl)!
                AF.request(apiURL).response { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data else { return }

                        do {
                            let data = try JSONDecoder().decode(DataHistory.self, from: data)
                            completion(.success(data))
                        } catch {
                            print(error)
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
            },
            failure: {
                print("No network")
            }
        )
        
        
        
        
        
        
    }
    
    
    
    func fetchData2(completion: @escaping (Result<Data, Error>) -> Void) {
        checkNetwork(
            success: {
                let apiURL = URL(string: url)!
                AF.request(apiURL).response { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data else { return }

                        do {
                            let data = try JSONDecoder().decode(Data.self, from: data)
                            completion(.success(data))
                        } catch {
                            print(error)
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
            },
            failure: {
                print("No network")
            }
        )
        
    }
    
    
    func fetchData(completion: @escaping (Result<Data, AFError>) -> Void) {
        checkNetwork(
            success: {
                let apiURL = URL(string: url)!
                AF.request(apiURL).responseDecodable(of: Data.self) { completion($0.result) }
            },
            failure: {
                print("No network")
            })
    }

    private func checkNetwork(success: @escaping () -> Void, failure: @escaping () -> Void) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                success()
            } else {
                failure()
            }
        }
        monitor.start(queue: .global())
    }
}
