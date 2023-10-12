//
//  PopupDelete.swift
//  FinanceTracker
//
//  Created by ardy on 11/10/23.
//

import UIKit

protocol PopupDeleteDelegate {
    func didTap()
}

class PopupDelete: UIViewController {
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    var delegate: PopupDeleteDelegate?
    
    static func instance() -> PopupDelete? {
        let storyboardId = String(describing: PopupDelete.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: .main)
        if let popUpView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? PopupDelete {
            popUpView.modalPresentationStyle = .overCurrentContext
            popUpView.modalTransitionStyle = .crossDissolve
            return popUpView
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // Button target
        leftButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(didTapRight), for: .touchUpInside)
        
        // Blur View
        let blurEffect = UIBlurEffect(style: .dark)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.frame = blurView.bounds
        blurView.addSubview(blur)
        
        // Popup View
        popupView.layer.cornerRadius = 20
        
        // Buttons
        leftButton.layer.cornerRadius = leftButton.frame.height / 2
        leftButton.layer.borderWidth = 4
        rightButton.layer.cornerRadius = rightButton.frame.height / 2
        
        
    }

    @objc func didTapRight() {
        delegate?.didTap()
        dismiss(animated: true)
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
