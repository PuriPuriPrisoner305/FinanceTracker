//
//  TransactionCell.swift
//  FinanceTracker
//
//  Created by ardy on 25/08/23.
//

import UIKit

class TransactionCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let identifier = String(describing: TransactionCell.self)
    static let nib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(data: TransactionDetail) {
        self.nameLabel.text = data.name
        self.descriptionLabel.text = data.description
        self.amountLabel.text = "+$\(data.amount)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        self.timeLabel.text = formatter.string(from: data.date)
    }

}
