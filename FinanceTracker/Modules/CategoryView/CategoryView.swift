//
//  CategoryView.swift
//  FinanceTracker
//
//  Created by ardy on 19/09/23.
//

import UIKit

protocol CategoryViewDelegate {
    func didTap(category: CategoryData, transType: ChartDataType)
}

class CategoryView: UIViewController {

    @IBOutlet weak var customSegment: CustomSegmentedControl!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var newCategoryButton: UIButton!
    
    var delegate: CategoryViewDelegate?
    
    var presenter: CategoryPresenter?
    var isFromEditing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setup() {
        customSegment.delegate = self
        let transType = presenter?.transType ?? .expense
        customSegment.setSelectedButton(index: transType == .expense ? 0 : 1)
        self.navigationController?.navigationBar.tintColor = .white
        setupTableViewView()
        setupFromEditTransaction()
    }
    
    func setupTableViewView() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(CategoryCell.nib, forCellReuseIdentifier: CategoryCell.identifier)
        categoryTableView.layer.cornerRadius = 16
    }
    
    func setupFromEditTransaction() {
        customSegment.isHidden = isFromEditing
    }
}

extension CategoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = presenter?.categories.count ?? 0
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell,
              let presenter = presenter
        else { return UITableViewCell() }
        cell.setupCell(data: presenter.categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = presenter else { return }
        delegate?.didTap(category: presenter.categories[indexPath.row], transType: presenter.transType)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CategoryView: CustomSegementedControlDelegate {
    func didTap(index: Int) {
        guard let presenter = presenter else { return }
        presenter.transType = index == 0 ? ChartDataType.expense : ChartDataType.income
        presenter.setupCategoryData()
        categoryTableView.reloadData()
    }
}
