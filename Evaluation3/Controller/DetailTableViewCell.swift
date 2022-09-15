//
//  DetailTableViewCell.swift
//  Evaluation3
//
//  Created by Student01 on 14/09/2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(history: CryptoHistory){
        valueLabel.text = String(Double(history.priceUsd)!.reduceScale(to: 2))
        dateLabel.text = formattedDate(date: history.date)
        
    }
    
    func formattedDate(date: String) -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        let dateDate = dateFormatterInput.date(from: date)
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd.MM.yy"
        return dateFormatterOutput.string(from: dateDate ?? Date())
     }
    
   
}
//stackoverflow
extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}
