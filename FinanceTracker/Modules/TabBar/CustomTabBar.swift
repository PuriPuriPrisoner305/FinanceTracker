//
//  CustomTabBar.swift
//  FinanceTracker
//
//  Created by Ardyansyah Wijaya on 17/08/23.
//

import UIKit

class CustomTabBar: UITabBar {
    
    public var didTapButton: (() -> ())?
    
    public lazy var middleButton: UIButton! = {
        let middleButton = UIButton()
        
        middleButton.frame.size = CGSize(width: 48, height: 48)
        
        let image = UIImage(systemName: "plus")
        middleButton.setImage(image, for: .normal)
        middleButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        middleButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        middleButton.tintColor = .white
        middleButton.layer.cornerRadius = middleButton.frame.width / 2
        
        middleButton.addTarget(self, action: #selector(self.middleButtonAction), for: .touchUpInside)
        
        self.addSubview(middleButton)
        return middleButton
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        middleButton.center = CGPoint(x: frame.width / 2, y: -5)
    }
    
    @objc func middleButtonAction(sender: UIButton) {
        didTapButton?()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        return self.middleButton.frame.contains(point) ? self.middleButton : super.hitTest(point, with: event)
    }
}
