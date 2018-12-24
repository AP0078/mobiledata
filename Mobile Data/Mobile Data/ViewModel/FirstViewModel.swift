//
//  FirstViewModel.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
class FirstViewModel: BaseViewModel {
    let chartDataPath: String = "/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=56"
    var yearlyRecords: [YearlyModel] = []
    func loadChartData() {
        let service = RequestManager.sharedInstance
        service.get(urlString: APIManager.urlString(path: chartDataPath)) { [unowned self] (success, data, error) in
            if success, let responseData = data {
                if let jsonData = try? JSONSerialization.data( withJSONObject: responseData, options: .prettyPrinted) {
                    if let responseModel = try? JSONDecoder().decode(ResponseBase.self, from: jsonData) {
                        if let records = responseModel.result?.records {
                            self.yearlyRecords = self.handleData(records: records)
                            self.delegate?.onSuccess()
                            return
                        }
                    }
                }
            } else {
                self.delegate?.onFailure(error: error)
            }
        }
    }
    func handleData(records: [Records]) -> [YearlyModel]{
        let tempList = records.reversed()
        var years = [String]()
        // Get all the Years
        for data in tempList {
            if let quarter = data.quarter, !years.contains(String(quarter.prefix(4))) {
                years.append(String(quarter.prefix(4)))
            }
        }
        var yearlyDataList = [YearlyModel]()
        for year in years {
            let yearlyData = YearlyModel()
            yearlyData.year = year
            var totalVolume: Double = 0.0
            var records = [Records]()
            for data in tempList where data.quarter?.contains(year) ?? false {
                if let volume = Double(data.volume_of_mobile_data ?? "0.0") {
                    totalVolume += volume
                }
                records.append(data)
            }
            yearlyData.volume = totalVolume
            yearlyData.records = records
            yearlyDataList.append(yearlyData)
        }
        return yearlyDataList
    }
}
