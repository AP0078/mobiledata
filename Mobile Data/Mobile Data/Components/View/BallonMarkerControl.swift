//
//  BallonMarkerControl.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
import UIKit
@IBDesignable
class BallonMarkerControl: UIControl {
    // MARK: Constants
    private struct Constants {
        static let thumbInset: CGFloat = 4
        static let thumbAnimationSpeed: Double = 0.2
    }
    // MARK: Outlets
    @IBOutlet private weak var rateLabel: UILabel! {
        didSet {
            rateLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet private weak var dateLabel: UILabel!{
        didSet {
            dateLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 6
            containerView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            containerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            containerView.layer.shadowOpacity = 0.3
            containerView.layer.shadowRadius = 5.0
        }
    }
    // MARK: variables
    private var view: UIView?
    private lazy var dateFormatter: DateFormatter = {
        let fomatter = DateFormatter()
        return fomatter
    }()
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    // MARK: Internal methods
    private func xibSetup() {
        view = loadViewFromNib()
        view?.frame = bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.isUserInteractionEnabled = false
        layoutSubviews()
        guard let resultView = view else {  return  }
        addSubview(resultView)
    }
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BallonMarkerControl", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    func loadData(_ rate: String?, date: String?) {
        if let tempRate = rate {
            let data = Double(tempRate) ?? 0.0
            self.rateLabel.text = String(format: "%.4f", data)
        }
        self.dateLabel.text = date
    }
}
