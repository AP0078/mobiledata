//
//  APIManager.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
struct APIManager {
    static var baseUrl = "https://data.gov.sg"
    static func urlString(path: String) -> String {
        return String(format: "%@%@", APIManager.baseUrl, path)
    }
}
