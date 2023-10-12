//
//  HomeScreenView.swift
//  FinanceTracker
//
//  Created by Ardyansyah Wijaya on 17/08/23.
//

import UIKit
import Charts

class HomeScreenView: UIViewController {
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var totalIncomeLabel: UILabel!
    @IBOutlet weak var totalExpenseLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var transactionView: UIView!
    @IBOutlet weak var transactionCollectionView: UICollectionView!
    
    @IBOutlet weak var transactionViewHeight: NSLayoutConstraint!
    
    var incomeDataEntries: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 6.0),
        ChartDataEntry(x: 4.0, y: 12.0),
        ChartDataEntry(x: 5.0, y: 3.0)
    ]
    
    var expenseDatEntries: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 12.0),
        ChartDataEntry(x: 1.0, y: 3.0),
        ChartDataEntry(x: 2.0, y: 1.0),
        ChartDataEntry(x: 3.0, y: 3.0),
        ChartDataEntry(x: 4.0, y: 4.0),
        ChartDataEntry(x: 5.0, y: 3.0)
    ]
    
    var presenter = HomeScreenPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTransactionViewConstraint()
    }
    
    func setup() {
        setupData()
        setupNotification()
        setupNavigation()
        setupChartView()
        setupTransactionView()
        setupCollectionView()
        setupTransactionData()
    }
    
    func setupData() {
        presenter.loadData()
    }
    
    func setupTransactionData() {
        totalIncomeLabel.text = "Rp. \(presenter.setupTotalIncome())"
        totalExpenseLabel.text = "Rp. \(presenter.setupTotalExpense())"
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollection), name: Notification.Name("NewTransactionSave"), object: nil)
    }
    
    func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Setup Chart View
    func setupChartView() {
        chartView.delegate = self
        chartView.backgroundColor = .black
        
        // Setup Data
        setupChartData()
        
        // Setup Axis
        setupChartAxis()
    
        // Animate Chart
        chartView.animate(xAxisDuration: 2, easingOption: .linear)
        chartView.animate(yAxisDuration: 2)
    }
    
    func setupChartData() {
        // Setup Set data
        let incomeDataSet = setupDataSet(type: .income)
        
        let expenseDataSet = setupDataSet(type: .expense)
        let data = LineChartData(dataSets: [incomeDataSet, expenseDataSet])
    
        chartView.legend.enabled = false
        chartView.data = data
    }
    
    func setupChartAxis() {
        let xAxis = chartView.xAxis
        let leftAxis = chartView.leftAxis
        let rightAxis = chartView.rightAxis
        
        // X Axis
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = false
        xAxis.labelTextColor = .white

        // Left Axis
        leftAxis.enabled = false
        
        // Right Axis
        rightAxis.drawAxisLineEnabled = false
        rightAxis.labelPosition = .outsideChart
        rightAxis.labelTextColor = .white

        // Remove Gridlines
        leftAxis.drawGridLinesEnabled = false
        rightAxis.drawGridLinesEnabled = false
        xAxis.drawGridLinesEnabled = false
    }
    
    func setupDataSet(type: ChartDataType) -> LineChartDataSet {
        let dataSet: LineChartDataSet
        if type == .income {
            dataSet = LineChartDataSet(entries: incomeDataEntries)
            let color = UIColor(red: 158/255.0, green: 239/255.0, blue: 152/255.0, alpha: 1.0)
            dataSet.colors = [color]
        } else {
            dataSet = LineChartDataSet(entries: expenseDatEntries)
            let color = UIColor(red: 225/255.0, green: 87/255.0, blue: 101/255.0, alpha: 1.0)
            dataSet.colors = [color]
        }
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.lineWidth = 2.5
        
        return dataSet
    }
    
    // MARK: Setup Transaction View
    func setupTransactionView() {
        // Setup cornerradius
        let cornerRadius: CGFloat = 50.0
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: transactionView.bounds,
                                      byRoundingCorners: [.topLeft, .topRight],
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        transactionView.layer.mask = maskLayer
        transactionView.clipsToBounds = true
    }
    
    // MARK: Setup Transaction View Constraints
    func setupTransactionViewConstraint() {
        // Setup Constraints
        transactionView.translatesAutoresizingMaskIntoConstraints = false
        let height = CGFloat(80 * presenter.transactionData.count)
        let screenHeight = self.view.frame.height
        if height < 500 {
            transactionViewHeight.constant = 500.0
        } else if height > screenHeight {
            transactionViewHeight.constant = screenHeight - 100
        } else {
            transactionViewHeight.constant = height
        }
        
        transactionCollectionView.backgroundColor = .white
        self.view.layoutIfNeeded()
    }
    
    // MARK: Setup Collection View
    func setupCollectionView() {
        transactionCollectionView.register(TransactionCell.nib, forCellWithReuseIdentifier: TransactionCell.identifier)
        
    }
    
    @objc func reloadCollection() {
        presenter.loadData()
        transactionCollectionView.reloadData()
    }
}

extension HomeScreenView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

extension HomeScreenView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter.transactionData.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else { return UICollectionViewCell() }
        cell.setupCell(data: presenter.transactionData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 80)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigation = navigationController else { return }
        presenter.navigateToEditTransaction(navigation: navigation, index: indexPath.row)
    }
}

extension HomeScreenView: UIScrollViewDelegate {
    
}
