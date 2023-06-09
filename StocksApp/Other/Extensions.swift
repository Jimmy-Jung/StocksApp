//
//  Extensions.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/03.
//

import Foundation
import UIKit

// Notification
extension Notification.Name {
    static let didAddToWatchList = Notification.Name("didAddToWatchList")
}

// NumberFormatter
extension NumberFormatter {
    static let percentFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

// ImageView
extension UIImageView {
    func setImage(with url: URL?) {
        guard let url = url else {
            return
        }
        DispatchQueue.global(qos: .userInteractive).async {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}

// MARK: - String

extension String {
    static func string(from timeInverval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInverval)
        return DateFormatter.prettyDateFormatter.string(from: date)
    }
    
    static func percentage(from double: Double) -> String {
        let formatter = NumberFormatter.percentFormatter
        return formatter.string(from: NSNumber(value: double)) ?? "\(double)"
    }
    
    static func formatted(number: Double) -> String {
        let formatter = NumberFormatter.numberFormatter
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

// MARK: - DateFormatter

extension DateFormatter {
    static let newsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    static let prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}


// MARK: - Add SubView

extension UIView {
    func addSubViews(_ view: UIView...) {
        view.forEach { addSubview($0) }
    }
}


// MARK: - Fraiming

extension UIView {
    
    /// 넓이
    var width: CGFloat {
        frame.size.width
    }
    
    /// 높이
    var height: CGFloat {
        frame.size.height
    }
    
    /// 왼쪽좌표
    var left: CGFloat {
        frame.origin.x
    }
    
    /// 우측 좌표
    var right: CGFloat {
        left + width
    }
    
    /// 탑 좌표
    var top: CGFloat {
        frame.origin.y
    }
    /// 바닥 좌표
    var bottom: CGFloat {
        top + height
    }
}

