//
//  DataLineChartView.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
import CoreGraphics
import Charts
class DataLineChartView: LineChartView {
    private var tempHighlight: Highlight?
    override func highlightValue(_ highlight: Highlight?, callDelegate: Bool) {
        if let high = highlight {
            tempHighlight = high
        }
        super.highlightValue(tempHighlight, callDelegate: callDelegate)
    }
}
