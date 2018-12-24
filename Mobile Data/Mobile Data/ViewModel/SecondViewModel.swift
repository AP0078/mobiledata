//
//  SecondViewModel.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
class SecondViewModel: BaseViewModel {
    let chartDataPath: String = "/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=56"
    var records: [Records] = []
    
    func loadChartData() {
        let service = RequestManager.sharedInstance
        service.get(urlString: APIManager.urlString(path: chartDataPath)) { [unowned self] (success, data, error) in
            if success, let responseData = data {
                if let jsonData = try? JSONSerialization.data( withJSONObject: responseData, options: .prettyPrinted) {
                    if let responseModel = try? JSONDecoder().decode(ResponseBase.self, from: jsonData) {
                        if let records = responseModel.result?.records {
                            self.records = records
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
}
