//
//  RadarMarkerView.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
import Charts
import CoreGraphics
import UIKit
protocol RadarMarkerViewDelegate: class {
    func refreshedContent(entry: ChartDataEntry, highlight: Highlight)
}
public class RadarMarkerView: MarkerView {
    weak var subDelegate: RadarMarkerViewDelegate?
    @IBOutlet var ringOne: UIView! {
        didSet {
            ringOne.layer.cornerRadius = ringOne.frame.height / 2
        }
    }
    @IBOutlet var ringTwo: UIView! {
        didSet {
            ringTwo.layer.cornerRadius = ringTwo.frame.height / 2
        }
    }
    @IBOutlet var ringThree: UIView! {
        didSet {
            ringThree.layer.cornerRadius = ringThree.frame.height / 2
        }
    }
    @IBOutlet weak var ringOneOrginYConstraint: NSLayoutConstraint! {
        didSet {
            ringOneOrginYConstraint.constant = 16.0
        }
    }
    public override func awakeFromNib() {
        self.offset.x = -self.frame.size.width / 2.0
        self.offset.y = -self.frame.size.height - 7.0
    }
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        subDelegate?.refreshedContent(entry: entry, highlight: highlight)
        layoutIfNeeded()
    }
}
