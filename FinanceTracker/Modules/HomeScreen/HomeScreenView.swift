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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChartView()
    }
    
    func setupChartView() {
        chartView.delegate = self
        chartView.backgroundColor = .black
        
        // Setup Data
        setupChartData()
        
        // Setup Axis
        setupChartAxis()
    
        // Animate Chart
        chartView.animate(xAxisDuration: 2, easingOption: .linear)
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
        let set1 = LineChartDataSet(entries: type == .income ? incomeDataEntries : expenseDatEntries)
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.colors = type == .income ? [.green] : [.red]
        
        return set1
    }
}

extension HomeScreenView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
