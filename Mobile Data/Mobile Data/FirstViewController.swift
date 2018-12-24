//
//  FirstViewController.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import UIKit
class FirstViewController: UIViewController {
     var viewModel: FirstViewModel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(MobileDataYearlyCell.nib, forCellWithReuseIdentifier: MobileDataYearlyCell.reuseIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mobile Data Usage"
        // Do any additional setup after loading the view, typically from a nib.
        self.viewModel = FirstViewModel(self)
        self.viewModel.loadChartData()
    }
}
extension FirstViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.yearlyRecords.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MobileDataYearlyCell.reuseIdentifier, for: indexPath) as!  MobileDataYearlyCell
        let record = self.viewModel.yearlyRecords[indexPath.row]
        cell.loadData(record: record)
        return cell
    }
}
extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
// MARK:- UICollectioViewDelegateFlowLayout methods
extension FirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: MobileDataYearlyCell.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero // margin between cells UIEdgeInsetsMake(top, left, bottom, right)
    }
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
extension FirstViewController: ViewModelDelegate {
    func onSuccess() {
        self.collectionView.reloadData()
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
