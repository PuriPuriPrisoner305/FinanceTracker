//
//  NewTransactionView.swift
//  FinanceTracker
//
//  Created by ardy on 25/08/23.
//

import UIKit

class NewTransactionView: UIViewController {
    @IBOutlet weak var segmentedControlView: CustomSegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    
    @IBOutlet weak var closeButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        amountTextfield.layer.cornerRadius = 20
        closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
    }
    
    @objc func tapCloseButton() {
        dismiss(animated: true)
    }
}
