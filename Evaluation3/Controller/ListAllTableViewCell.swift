//
//  ListAllTableViewCell.swift
//  Evaluation3
//
//  Created by Student01 on 15/09/2022.
//


import UIKit
import AlamofireImage

class ListAllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCrypto: UIImageView!
    @IBOutlet weak var nameCrypto: UILabel!

    
    static let identifier = "ListAllTableViewCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(crypto: Crypto){
        nameCrypto.text = crypto.id
        imgCrypto.af.setImage(withURL: URL(string: crypto.icon)!)
    }
}
