//
//  CustomSegmentedControl.swift
//  FinanceTracker
//
//  Created by ardy on 27/08/23.
//

import UIKit

protocol CustomSegementedControlDelegate {
    func didTap(index: Int)
}

@IBDesignable
class CustomSegmentedControl: UIView {
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable
    var textColor: UIColor = UIColor.gray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textFont: UIFont = .systemFont(ofSize: 20, weight: .bold) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var selector: UIView!
    var buttons: [UIButton] = []
    
    var delegate: CustomSegementedControlDelegate?
    
    func updateView() {
        // Clear View
        buttons.removeAll()
        subviews.forEach{ $0.removeFromSuperview() }
        layer.cornerRadius = 10
        
        // Setup Button
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = textFont
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        // Setup Selector
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = 10
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        // Setup Stackview for buttons
        let buttonStackView = UIStackView(arrangedSubviews: buttons)
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        addSubview(buttonStackView)
        
        // Setup constraints
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (index, btn) in buttons.enumerated() {
            if btn == button {
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(index)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
                delegate?.didTap(index: index)
            } else {
                btn.setTitleColor(textColor, for: .normal)
            }
        }
    }
    
    func setSelectedButton(index: Int) {
        buttons[index].sendActions(for: .touchUpInside)
    }
    
}
