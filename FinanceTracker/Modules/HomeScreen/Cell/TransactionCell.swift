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
        self.iconImageView.image = UIImage(systemName: data.categoryImage)
        self.nameLabel.text = data.categoryName
        self.descriptionLabel.text = data.description
        self.amountLabel.attributedText = setupAmount(data: data)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        self.timeLabel.text = setupTransactionTime(date: data.date)
    }
    
    func setupAmount(data: TransactionDetail) -> NSAttributedString {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_ID")
        formatter.groupingSeparator = ","
        
        if let formattedNumber = formatter.string(from: NSNumber(value: data.amount)) {
            let type = data.transType == .expense ? "-" : "+"
            let attributedText = NSAttributedString(
                string: "\(type)\(data.currency). \(formattedNumber)",
                attributes: [NSAttributedString.Key.foregroundColor:  data.transType == .expense ? UIColor.systemRed : UIColor.systemGreen])
            
            return attributedText
        }
        return NSAttributedString(string: "Rp. 0")
    }
    
    func setupTransactionTime(date: Date) -> String {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day], from: date, to: Date())
        
        let dateFormatter = DateFormatter()

        if let day = dateComponents.day {
            print(day, date)
            if day < 1 {
                dateFormatter.dateFormat = "h:mm a"
            } else if day == 1 {
                return "Yesterday"
            } else {
                dateFormatter.dateFormat = "MMM d"
            }
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
}
