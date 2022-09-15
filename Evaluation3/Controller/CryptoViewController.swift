//
//  ViewController.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import UIKit
import SafariServices




class CryptoViewController: UIViewController {
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet var cryptoTableView: UITableView!
    private let apiService = ApiServiceImpl()

    private var result: Data = Data(data: [Coin]())
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cryptoTableView.dataSource = self
        cryptoTableView.delegate = self
        cryptoTableView.register(UINib(nibName: CryptoTableViewCell.identifier, bundle: .main),
                           forCellReuseIdentifier: CryptoTableViewCell.identifier)
        
        /*
        apiServiceImpl.fetchData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.result = data
                self.cryptoTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
         */
        cryptoTableView.rowHeight = 200
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.startAnimating()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: UIControl.Event.valueChanged)
        
        
        
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        cryptoTableView.refreshControl = refreshcontrol
        refreshData()
        
        
        
    }
    
    @objc
    func refreshData(){
        
        apiService.fetchData2 { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.result = data
                self.cryptoTableView.reloadData()
                self.loader.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        self.cryptoTableView.refreshControl?.endRefreshing()
        
    }
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl){
        if sender .selectedSegmentIndex == 0{
            print("hello1")
            
        }
        if sender .selectedSegmentIndex == 1{
            print("hello2")
        }
        if sender .selectedSegmentIndex == 2{
            print("hello3")
        }

    }
    
    
    

}

extension CryptoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cryptoTableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier,
                                                       for: indexPath) as? CryptoTableViewCell
        else {
            fatalError("Unable to dequeue Cell")
        }

        cell.setupCell(coin: result.data[indexPath.row])
        cell.delegate = self

        return cell
    }


}

extension CryptoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: DetailCryptoViewController.indentifier) as! DetailCryptoViewController
        
        vc.coin = result.data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
     
}

extension CryptoViewController: CryptoCellDelegate{
    func tap(coin: Coin) {
        
        if let explorer = coin.explorer,let url = URL(string: explorer){
            
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    
    }
}
    
