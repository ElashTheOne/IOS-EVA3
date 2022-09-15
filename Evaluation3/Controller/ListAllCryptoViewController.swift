//
//  ListAllCryptoViewController.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import UIKit


class ListAllCryptoViewController: UIViewController {
    
    private let apiService = ApiServiceImpl()
    private var result: DataCrypto = DataCrypto(coins: [Crypto]())
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: ListAllTableViewCell.identifier, bundle: .main),
                           forCellReuseIdentifier: ListAllTableViewCell.identifier)
        listTableView.rowHeight = 200
        
        apiService.fetchCrypto { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.result = data
                self.listTableView.reloadData()
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

extension ListAllCryptoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: ListAllTableViewCell.identifier,
                                                       for: indexPath) as? ListAllTableViewCell
        else {
            fatalError("Unable to dequeue Cell")
        }

        cell.setupCell(crypto: result.coins[indexPath.row])
        

        return cell
    }
    
    
}
