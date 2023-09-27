//
//  NewTransactionView.swift
//  FinanceTracker
//
//  Created by ardy on 25/08/23.
//

import UIKit
import CoreData

class NewTransactionView: UIViewController {
    @IBOutlet weak var segmentedControlView: CustomSegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // Amount View
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var amountCurrencyLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    
    // Category View
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    // Description View
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    // Date View
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
        
    var presenter = NewTransactionPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupCoreData()
        setupAction()
        setupView()
        
        setupCategoryData(category: presenter.selectedCategory)
        setupDate()
        
        amountView.layer.cornerRadius = amountView.frame.height / 2
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        amountTextfield.delegate = self
        segmentedControlView.delegate = self
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
        
    func setupAction() {
        // Category View
        let categoryTapGesture = UITapGestureRecognizer(target: self, action: #selector(categoryViewTapped))
        categoryTapGesture.numberOfTapsRequired = 1
        categoryView.addGestureRecognizer(categoryTapGesture)
        
        // Date View
        let dateTapGesture = UITapGestureRecognizer(target: self, action: #selector(dateViewTapped))
        dateTapGesture.numberOfTapsRequired = 1
        datePickerView.addGestureRecognizer(dateTapGesture)
        
        // Textfield
        let textFieldTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(textFieldTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Description Textfield
        descriptionTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // Save Button
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }
    
    func setupView() {
        categoryView.layer.cornerRadius = 20
        descriptionView.layer.cornerRadius = 20
        datePickerView.layer.cornerRadius = 20
        
        // Save Button
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
    func setupCategoryData(category: CategoryData) {
        presenter.selectedCategory = category
        categoryIcon.image = UIImage(systemName: category.image)
        categoryLabel.text = category.name
    }
    
    func setupDate() {
        let transDate = presenter.transactionTime
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day], from: transDate, to: Date())
        
        let dateFormatter = DateFormatter()
        
        if let day = dateComponents.day {
            if day < 7 {
                dateFormatter.dateFormat = "EEEE, h:mm a"
            } else {
                dateFormatter.dateFormat = "MMM d, h:mm a"
            }
            dateLabel.text = dateFormatter.string(from: transDate)
        }
        
    }
    
    func setupSegmentedControl() {
        let type = presenter.transType
        self.presenter.selectedCategory = type == .expense ? CategoryEntity.expenseCategories[0] : CategoryEntity.incomeCategories[0]
        self.titleLabel.text = type == .expense ? "Add Expense" : "Add Income"
        self.setupCategoryData(category: self.presenter.selectedCategory)
    }
    
    func setupCoreData() {
        presenter.setupCoreData()
    }
    
    func setupEmptyAmount(isEmpty: Bool) {
        if isEmpty {
            amountView.layer.borderWidth = 1
            amountView.layer.borderColor = UIColor.red.cgColor
            amountTextfield.attributedPlaceholder = NSAttributedString(
                string: "Please fill in amount",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.8)]
            )
            amountTextfield.becomeFirstResponder()
        } else {
            amountView.layer.borderWidth = 0
            amountTextfield.attributedPlaceholder = NSAttributedString(
                string: "0",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
            )
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !descriptionTextField.isFirstResponder { return }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if !descriptionTextField.isFirstResponder { return }
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        if amountTextfield.isFirstResponder {
            amountTextfield.resignFirstResponder()
        } else if descriptionTextField.isFirstResponder {
            descriptionTextField.resignFirstResponder()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter.transDesc = textField.text ?? ""
    }
    
    @objc func saveData() {
        let amount = amountTextfield.text ?? ""
        if amount.isEmpty {
            setupEmptyAmount(isEmpty: true)
            return
        }
        presenter.saveData()
        dismissView()
        NotificationCenter.default.post(name: Notification.Name("NewTransactionSave"), object: nil)
    }
    
}

extension NewTransactionView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        setupEmptyAmount(isEmpty: false)
        formatTextField(string: string, textField: textField, range: range)
        presenter.transAmount = textField.text ?? ""
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func formatTextField(string: String, textField: UITextField, range: NSRange) {
        let allowedCharacters = "0123456789,"
        let cs = NSCharacterSet(charactersIn: allowedCharacters).inverted
        let filtered = string.components(separatedBy: cs)
        let component = filtered.joined(separator: "")
        let tempString = string.filter(allowedCharacters.contains)
        let isNumeric = tempString == component
        if isNumeric {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.decimalSeparator = ","
            formatter.groupingSeparator = ","
            guard let text = textField.text else {
                textField.text = nil
                return
            }
            let newString = (text as NSString).replacingCharacters(in: range, with: tempString)
            let numberWithCommas = newString.replacingOccurrences(of: ",", with: "")
            guard let number = formatter.number(from: numberWithCommas) else {
                return textField.text = nil
            }
            let diff = Int(truncating: number)
            guard let diffNumber = formatter.number(from: String(diff)),
                  let diffFormat = formatter.string(from: diffNumber) else { return }
            textField.text = diffFormat
        }
    }

}

// MARK: Navigation
extension NewTransactionView {
    @objc func categoryViewTapped() {
        navigateToCategoryView()
    }
    
    @objc func dateViewTapped() {
        navigateToDatePickerView()
    }
    
    func navigateToCategoryView() {
        guard let navigation = navigationController else { return }
        presenter.navigateToCategoryView(navigation: navigation, delegate: self)
    }
    
    func navigateToDatePickerView() {
        guard let navigation = navigationController else { return }
        presenter.navigateToDatePickerView(navigation: navigation, delegate: self)
    }
    
}

// MARK: Custom Segment Delegation
extension NewTransactionView: CustomSegementedControlDelegate {
    func didTap(index: Int) {
        presenter.transType = index == 0 ? .expense : .income
        setupSegmentedControl()
    }
    
}

// MARK: Category Delegation
extension NewTransactionView: CategoryViewDelegate {
    func didTap(category: CategoryData, transType: ChartDataType) {
        presenter.transType = transType
        segmentedControlView.setSelectedButton(index: transType == .expense ? 0 : 1)
        setupCategoryData(category: category)
    }
}

// MARK: Date Picker Delegation
extension NewTransactionView: DatePickerViewDelegate {
    func didTap(date: Date) {
        setupDate()
    }
}
