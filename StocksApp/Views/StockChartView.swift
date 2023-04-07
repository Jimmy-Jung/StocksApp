//
//  StockcChartView.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/07.
//

import UIKit

class StockChartView: UIView {
    
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxisBool: Bool
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    /// ResetChartView
    func reset() {
        
    }
    
    func configure(with viewModel: ViewModel) {
        
    }
}
