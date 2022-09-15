//
//  DetailCryptoViewController.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//


import UIKit

class DetailCryptoViewController: UIViewController {
    
    
    static let indentifier = "DetailCryptoViewController"
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var result = DataHistory(data: [CryptoHistory]())
    @IBOutlet var detailTableView: UITableView!
    private let apiService = ApiServiceImpl()
    var coin: Coin?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: .main),
                           forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        detailTableView.rowHeight = 200
        
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.startAnimating()
        
        self.name.text = coin?.name
        self.value.text = coin?.priceUsd
        
        
        
        
        apiService.fetchHistory(coin: coin!) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.result = data
                self.detailTableView.reloadData()
                self.loader.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
       
        
        
    }
    
    
}

extension DetailCryptoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier,
                                                       for: indexPath) as? DetailTableViewCell
        else {
            fatalError("Unable to dequeue Cell")
        }

        cell.setupCell(history: result.data[indexPath.row])
        
        

        return cell
    }
    
}




