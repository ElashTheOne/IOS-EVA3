//
//  CryptoTableViewCell.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import UIKit


protocol CryptoCellDelegate: AnyObject {
    func tap(coin: Coin)
}

class CryptoTableViewCell: UITableViewCell {
    
    weak var delegate: CryptoCellDelegate?
    private var coin: Coin!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    static let identifier = "CryptoTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupCell(coin: Coin){
        self.coin = coin
        nameLabel.text = coin.name
        rankLabel.text = coin.rank
        valueLabel.text = coin.priceUsd
        rateLabel.text = coin.changePercent24Hr
        
    }
    
    @IBAction func displayInfoCoin(_ sender: Any) {
        
        delegate?.tap(coin: coin)
            
    }
        
}
