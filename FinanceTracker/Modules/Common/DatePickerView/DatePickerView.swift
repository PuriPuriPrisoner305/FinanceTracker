//
//  DatePickerView.swift
//  FinanceTracker
//
//  Created by ardy on 24/09/23.
//

import UIKit

protocol DatePickerViewDelegate {
    func didTap(date: Date)
}

class DatePickerView: UIViewController {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedDate: Date = Date()
    
    var delegate: DatePickerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupDatePicker()
    }
    
    func setupView() {
        datePickerView.layer.cornerRadius = 10
        datePicker.date = selectedDate
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.frame = blurView.bounds
        blurView.addSubview(blur)
        
        // Button
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
    func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurViewTapped))
        blurView.addGestureRecognizer(tapGesture)
    }
    
    func setupDatePicker() {
        datePicker.maximumDate = Date()
        saveButton.addTarget(self, action: #selector(datePickerTapped), for: .touchUpInside)
    }
    
    @objc func blurViewTapped() {
        self.dismiss(animated: true)
    }

    @objc func datePickerTapped() {
        delegate?.didTap(date: datePicker.date)
        self.dismiss(animated: true)
    }
}
