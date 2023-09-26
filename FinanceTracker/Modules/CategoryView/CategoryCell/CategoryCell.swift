//
//  CategoryCell.swift
//  FinanceTracker
//
//  Created by ardy on 19/09/23.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    static let identifier = String(describing: CategoryCell.self)
    static let nib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data: CategoryData) {
        iconImage.image = UIImage(systemName: data.image)
        categoryNameLabel.text = data.name
    }
    
}
