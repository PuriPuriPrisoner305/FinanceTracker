//
//  TransactionView.swift
//  FinanceTracker
//
//  Created by ardy on 27/09/23.
//

import UIKit

class TransactionView: UIViewController {
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
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var presenter: TransactionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setup() {
        setupView()
        setupAction()
        setupNavigation()
        setupAmountTextfield()
        setupCategoryData(data: presenter?.transactionDetail)
        setupDescriptionTextfield()
        setupDate()
    }
    
    func setupNavigation() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setupView() {
        amountView.layer.cornerRadius = 20
        categoryView.layer.cornerRadius = 20
        descriptionView.layer.cornerRadius = 20
        datePickerView.layer.cornerRadius = 20
        
        amountView.layer.borderWidth = 4
        amountView.layer.borderColor = UIColor.black.cgColor
        categoryView.layer.borderWidth = 4
        categoryView.layer.borderColor = UIColor.black.cgColor
        descriptionView.layer.borderWidth = 4
        descriptionView.layer.borderColor = UIColor.black.cgColor
        datePickerView.layer.borderWidth = 4
        datePickerView.layer.borderColor = UIColor.black.cgColor
        
        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
        deleteButton.layer.borderWidth = 4
        deleteButton.layer.borderColor = UIColor.black.cgColor
        let attribute = NSAttributedString(
            string: "Delete",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold),
                         NSAttributedString.Key.foregroundColor : UIColor.black]
        )
        deleteButton.setAttributedTitle(attribute, for: .normal)
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.backgroundColor = .black
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
        // Delete Button
        deleteButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        // Save Button
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }
    
    func setupAmountTextfield() {
        guard let presenter = presenter else { return }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_ID")
        formatter.groupingSeparator = ","
        
        if let formattedNumber = formatter.string(from: NSNumber(value: presenter.transactionDetail.amount)) {
            amountTextfield.text = formattedNumber
        }
    }
    
    func setupDescriptionTextfield() {
        descriptionTextField.text = presenter?.transactionDetail.description
    }
    
    func setupDate() {
        guard let date = presenter?.transactionDetail.date else { return }
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day], from: date, to: Date())
        
        let dateFormatter = DateFormatter()
        
        if let day = dateComponents.day {
            if day < 7 {
                dateFormatter.dateFormat = "EEEE, h:mm a"
            } else {
                dateFormatter.dateFormat = "MMM d, h:mm a"
            }
            dateLabel.text = dateFormatter.string(from: date)
        }
    }

    func setupCategoryData(data: TransactionDetail? = nil, category: CategoryData? = nil) {
        if category != nil {
            presenter?.transactionDetail.categoryName = category!.name
            presenter?.transactionDetail.categoryImage = category!.image
            categoryIcon.image = UIImage(systemName: category!.image)
            categoryLabel.text = category!.name
            return
        } else {
            guard let data = data else { return }
            categoryIcon.image = UIImage(systemName: data.categoryImage)
            categoryLabel.text = data.categoryName
        }
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
        presenter?.transactionDetail.description = textField.text ?? ""
    }
    
    @objc func dismissView() {
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name("NewTransactionSave"), object: nil)
    }
    
    @objc func deleteData() {
        guard let navigation = navigationController else { return }
        presenter?.showPopupDelete(navigation: navigation, delegate: self)
    }
    
    @objc func saveData() {
        let amount = amountTextfield.text ?? ""
        if amount.isEmpty {
            setupEmptyAmount(isEmpty: true)
            return
        }
        presenter?.saveData()
        dismissView()
    }
    
}

// MARK: Navigation
extension TransactionView {
    @objc func categoryViewTapped() {
        navigateToCategoryView()
    }
    
    @objc func dateViewTapped() {
        navigateToDatePickerView()
    }
    
    func navigateToCategoryView() {
        guard let navigation = navigationController,
              let presenter = presenter
        else { return }
        presenter.navigateToCategoryView(navigation: navigation, delegate: self)
    }
    
    func navigateToDatePickerView() {
        guard let navigation = navigationController,
              let presenter = presenter
        else { return }
        presenter.navigateToDatePickerView(navigation: navigation, delegate: self)
    }
    
}

extension TransactionView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        formatTextField(string: string, textField: textField, range: range)
        let amount = (textField.text ?? "").filter("0123456789.".contains)
        presenter?.transactionDetail.amount = Double(amount) ?? 0
        return false

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

// MARK: Category Delegation
extension TransactionView: CategoryViewDelegate {
    func didTap(category: CategoryData, transType: ChartDataType) {
        setupCategoryData(category: category)
    }
}

// MARK: Date Picker Delegation
extension TransactionView: DatePickerViewDelegate {
    func didTap(date: Date) {
        presenter?.transactionDetail.date = date
        setupDate()
    }
}

// MARK: Popup Delete Delegate
extension TransactionView: PopupDeleteDelegate {
    func didTap() {
        presenter?.deleteData()
        dismissView()
    }
}
