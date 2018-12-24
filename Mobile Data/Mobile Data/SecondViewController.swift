//
//  SecondViewController.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//

import UIKit
import Charts
class SecondViewController: UIViewController, ChartViewDelegate {
    var viewModel: SecondViewModel!
    @IBOutlet var chartView: DataLineChartView!
    @IBOutlet var tempView: BallonMarkerControl! {
        didSet {
            tempView.isHidden = true
        }
    }
    weak var axisFormatDelegate: IAxisValueFormatter?
    lazy var markerView: RadarMarkerView = {
        let mask = RadarMarkerView.viewFromXib() as! RadarMarkerView
        mask.subDelegate = self
        mask.chartView = chartView
        return mask
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chartSetting()
        // Do any additional setup after loading the view, typically from a nib.
        self.viewModel = SecondViewModel(self)
        self.viewModel.loadChartData()
    }
    //MARKL Chart setting/ appearance
    private func chartSetting() {
        axisFormatDelegate = self
        chartView.delegate = self
        chartView.legend.enabled = false
        chartView.xAxis.valueFormatter = axisFormatDelegate
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.gridLineDashLengths = [3, 3]
         chartView.xAxis.gridColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //RIGHT AXIS
        let rightAxis = chartView.rightAxis
        rightAxis.removeAllLimitLines()
        rightAxis.drawGridLinesEnabled = false
        rightAxis.drawLabelsEnabled = false
        //SET MARKER VIEW
        chartView.marker = markerView
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.forceLabelsEnabled = true
        chartView.xAxis.granularity = 1
        chartView.xAxis.labelTextColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        chartView.legend.form = .line
    }
    //MARK: Load LineChart
    func setData() {
        var values = [ChartDataEntry]()
        for i in 0..<self.viewModel.records.count {
            let data = self.viewModel.records[i]
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(data.volume_of_mobile_data ?? "0.0") ?? 0.0)
            values.append(dataEntry)
        }
        //SET CHART DATA POINT
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawLabelsEnabled = false
        //DATASET
        let dataSet = LineChartDataSet(values: values, label: "")
        dataSet.drawIconsEnabled = false
        dataSet.mode = .linear
        dataSet.highlightLineWidth = 1
        dataSet.highlightColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.setColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        dataSet.lineWidth = 2
        dataSet.circleRadius = 0
        dataSet.drawCircleHoleEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 9)
        dataSet.formLineWidth = 1
        dataSet.formSize = 15
        dataSet.drawValuesEnabled = false
        //CHART COLOR
        let gradientColors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor,
                              #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        dataSet.fillAlpha = 0.7
        dataSet.fill = Fill(linearGradient: gradient, angle: 90)
        dataSet.drawFilledEnabled = true
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
        //SET DEFAULT HIGHLIGHT
        let dataEntry = values[values.count / 2]
        self.chartView.highlightValue(x: dataEntry.x, y: dataEntry.y, dataSetIndex: 0)
    }
}
extension SecondViewController: ViewModelDelegate {
    func onSuccess() {
        self.setData()
    }
    func onFailure(error: Error?) {
        let alertController = UIAlertController(title: "Error", message: error?._userInfo?["message"] as? String, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("error dismiss")
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
// MARK: axisFormatDelegate
extension SecondViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index < self.viewModel.records.count {
            let data = self.viewModel.records[index]
            return self.getDataString(string: data.quarter ?? "")
        }
        return ""
    }
    func getDataString(string: String) -> String {
        return string.replacingOccurrences(of: "-", with: "\n")
    }
}
extension SecondViewController: RadarMarkerViewDelegate {
    func refreshedContent(entry: ChartDataEntry, highlight: Highlight) {
        if self.tempView.isHidden {
            self.tempView.isHidden = false
        }
        let charViewLeftAligment: CGFloat = 15.0
        let leftMost =  self.tempView.frame.width / 2
        let rightMost = UIScreen.main.bounds.width - (leftMost + charViewLeftAligment)
        if leftMost...rightMost ~=  highlight.drawX + charViewLeftAligment {
            self.tempView.center = CGPoint(x: highlight.drawX, y: 0)
        }
        let index =  Int(entry.x)
        if index < self.viewModel.records.count {
            let data = self.viewModel.records[index]
            tempView.loadData(data.volume_of_mobile_data, date: data.quarter)
        }
    }
}
