//
//  BaseCollectionCell.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
import UIKit
class BaseCollectionCell: UICollectionViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    public static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
}
