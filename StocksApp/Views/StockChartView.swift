//
//  StockcChartView.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/07.
//

import UIKit
import Charts

class StockChartView: UIView {
    
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxisBool: Bool
        let fillColor: UIColor
    }
    
    private let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.legend.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        return chartView
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(chartView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = bounds
    }

    /// ResetChartView
    func reset() {
        chartView.data = nil
    }
    
    func configure(with viewModel: ViewModel) {
        var entries = [ChartDataEntry]()

        for (index, value) in viewModel.data.enumerated() {
            entries.append(
                .init(
                    x: Double(index),
                    y: value
                )
            )
        }
        
        chartView.rightAxis.enabled = viewModel.showAxisBool
        chartView.legend.enabled = viewModel.showLegend
        
        let dataSet = LineChartDataSet(entries: entries, label: "7 Days")
        dataSet.fillColor = viewModel.fillColor
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
    
}
