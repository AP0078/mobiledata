//
//  MobileDataYearlyCell.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 25/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
import UIKit
import Charts
class MobileDataYearlyCell: BaseCollectionCell {
    static let height: CGFloat = 240.0
    weak var formatDelegate: IValueFormatter?
    var record: YearlyModel = YearlyModel()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var volumLabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            containerView.layer.cornerRadius = 8
            containerView.layer.masksToBounds = false
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
            containerView.layer.shadowRadius = 4.0
            containerView.layer.shadowOpacity = 0.1

        }
    }
    let colorList: [UIColor] = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)]
    @IBOutlet weak var pieChartView: PieChartView!
    
    func loadData(record: YearlyModel) {
        self.titleLabel.text = "Year: " + record.year
        self.volumLabel.text = String(format: "Volume: %.4f", record.volume)
        self.record = record
        self.setChart(centerText: record.year)
    }
    
   fileprivate func setChart(centerText: String?) {
        var dataEntries = [ChartDataEntry]()
        var colors = [UIColor]()
        
        for i in 0..<self.record.records.count {
            colors.append(self.colorList[i])
            let data = self.record.records[i]
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(data.volume_of_mobile_data ?? "0.0") ?? 0.0)
            dataEntries.append(dataEntry)
        }
        formatDelegate = self
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.centerText = centerText
        pieChartView.holeRadiusPercent = 0.5
        //pieChartView.transparentCircleColor = UIColor.clear
        pieChartDataSet.valueFormatter = formatDelegate
        
        let attribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let attrString = NSAttributedString(string: pieChartView.centerText!, attributes: attribute)
        pieChartView.centerAttributedText = attrString
        
        pieChartView.holeColor = UIColor.clear
        pieChartView.data = pieChartData
        pieChartDataSet.valueFont = UIFont.systemFont(ofSize: 11)
        pieChartDataSet.valueColors = [UIColor.darkGray]
        pieChartView.legend.enabled = false
        pieChartDataSet.colors = colors
    }
    
}
// MARK: axisFormatDelegate
extension MobileDataYearlyCell: IValueFormatter {
    
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        let index =  Int(entry.x)
        if index < self.record.records.count {
            let data = self.record.records[index]
            if let quarter = data.quarter {
                var temp = quarter.replacingOccurrences(of: self.record.year, with: "")
                temp = temp.replacingOccurrences(of: "-", with: "")
                return String(format: "%@\n%.4f", temp, value)
            }
        }
        return String(format: "%.4f", value)
    }
}
