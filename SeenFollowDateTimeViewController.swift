//
//  SeenFollowDateTimeViewController.swift
//  TuVi
//
//  Created by Kahn on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

protocol SeenFollowDateTimeProtocol: class {
    func goToResultPage(resultDic: [String: String], arrData: [TagObject])
    func showLoadingView(isShowing: Bool)
    func showAlertError()
}

class SeenFollowDateTimeViewController: BaseViewController {
    @IBOutlet weak var lbGioSinh: UILabel!

    @IBOutlet weak var lbNamSinh: UILabel!
    @IBOutlet weak var lbThangSinh: UILabel!
    @IBOutlet weak var lbNgaySinh: UILabel!
    var yearArr = [String]()
    let dropDownGio = DropDown()
    var gioValue = 1
    
    let dropDownNgay = DropDown()
    var ngayValue = 1
    
    let dropDownThang = DropDown()
    var thangValue = 1
    
    let dropDownYear = DropDown()
    var yearValue = 1
    
    var seenFollowDateViewModel = SeenFollowDateTimeViewModel()
    var router: SeenFollowDateTimeRouter!
    

    var shouldShowFullAds = true
    override func viewDidLoad() {
        super.viewDidLoad()
        //startGetHtml()
        // Do any additional setup after loading the view.
        setupDropDownForYear()
        setupDropDownForGioSinh()
        setupDropDownForNgaySinh()
        setupDropDownForThangSinh()
        
        seenFollowDateViewModel.seenDateTimePro = self
        router = SeenFollowDateTimeRouter(seenFollowDateTimeVC: self)
        
        //pre-load ad
        RevmobHelper.share.loadFullscreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        if !self.isMovingToParentViewController {
            if Utilities.isValidForShowFullAds() {
                if shouldShowFullAds {
                    RevmobHelper.share.showLoadedFullscreen()
                }
            }
        }
    }
    
    @IBAction func backToHome(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func goToResultPage(_ sender: Any) {
        print("gio sinh : \(gioValue), ngay sinh : \(ngayValue), thang sinh : \(thangValue), nam sinh : \(yearValue)")
        seenFollowDateViewModel.startGetAndPraseTime(gio: gioValue, ngay: ngayValue, thang: thangValue, nam: yearValue)
    }
    
    // Create Array from year 1960 to current year
    func createArrayForYear() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy"
        
        let currentYear = Int(formatter.string(from: NSDate() as Date))
        
        for i in 1960...currentYear! {
            let castString = String(i)
            yearArr.append(castString)
        }
        
    }
    
    // For time
    func setupDropDownForGioSinh() {
        dropDownGio.anchorView = lbGioSinh
        dropDownGio.dataSource = [
          "Giờ Tý (23h00 - 01h00)",
          "Giờ Sửu (01h00 - 03h00)",
          "Giờ Dần (03h00 - 05h00)",
          "Giờ Mão (05h00 - 07h00)",
          "Giờ Thìn (07h00 - 09h00)",
          "Giờ Tỵ (09h00 - 11h00)",
          "Giờ Ngọ (11h00 - 13h00)",
          "Giờ Mùi (13h00 - 15h00)",
          "Giờ Thân (15h00 - 17h00)",
          "Giờ Dậu (17h00 - 19h00)",
          "Giờ Tuất (19h00 - 21h00)",
          "Giờ Hợi (21h00 - 23h00)"
        ]
        dropDownGio.direction = .bottom
        dropDownGio.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownGio.hide()
            self.gioValue = index + 1
            self.lbGioSinh.text = item
            print("Selected item: \(item) at index: \(index)")
        }
        dropDownGio.bottomOffset = CGPoint(x: 0, y:(dropDownGio.anchorView?.plainView.bounds.height)!)
        dropDownGio.selectRow(at: 0)
        lbGioSinh.text = dropDownGio.selectedItem
        
        
        // Add gesture for UILabel
        lbGioSinh.isUserInteractionEnabled = true // Remember to do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapChooseTime))
        lbGioSinh.addGestureRecognizer(tap)
    }
    
    // For day birth
    func setupDropDownForNgaySinh() {
        dropDownNgay.anchorView = lbNgaySinh
        var arrDay = [String]()
        for i in 1...31 {
            arrDay.append(String(i))
        }
        dropDownNgay.dataSource = arrDay
        dropDownNgay.direction = .bottom
        dropDownNgay.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownNgay.hide()
            self.ngayValue = index + 1
            self.lbNgaySinh.text = item
            print("Selected item: \(item) at index: \(index)")
        }
        dropDownNgay.bottomOffset = CGPoint(x: 0, y:(dropDownNgay.anchorView?.plainView.bounds.height)!)
        dropDownNgay.selectRow(at: 0)
        lbNgaySinh.text = dropDownNgay.selectedItem
        
        
        // Add gesture for UILabel
        lbNgaySinh.isUserInteractionEnabled = true // Remember to do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapChooseDay))
        lbNgaySinh.addGestureRecognizer(tap)
    }
    
    // For month birth
    func setupDropDownForThangSinh() {
        dropDownThang.anchorView = lbThangSinh
        var arrMonth = [String]()
        for i in 1...12 {
            arrMonth.append(String(i))
        }
        dropDownThang.dataSource = arrMonth
        dropDownThang.direction = .bottom
        dropDownThang.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownThang.hide()
            self.thangValue = index + 1
            self.lbThangSinh.text = item
            print("Selected item: \(item) at index: \(index)")
        }
        dropDownThang.bottomOffset = CGPoint(x: 0, y:(dropDownThang.anchorView?.plainView.bounds.height)!)
        dropDownThang.selectRow(at: 0)
        lbThangSinh.text = dropDownThang.selectedItem
        
        
        // Add gesture for UILabel
        lbThangSinh.isUserInteractionEnabled = true // Remember to do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapChooseMonth))
        lbThangSinh.addGestureRecognizer(tap)
    }
    
    // For Year birth
    func setupDropDownForYear() {
        createArrayForYear()
        dropDownYear.anchorView = lbNamSinh
        dropDownYear.dataSource = yearArr
        dropDownYear.direction = .bottom
        dropDownYear.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownYear.hide()
            self.yearValue = Int(self.yearArr[index])!
            self.lbNamSinh.text = item
            print("Selected item: \(item) at index: \(index)")
        }
        dropDownYear.bottomOffset = CGPoint(x: 0, y:(dropDownYear.anchorView?.plainView.bounds.height)!)
        dropDownYear.selectRow(at: 30)
        lbNamSinh.text = dropDownYear.selectedItem
        yearValue = Int(dropDownYear.selectedItem!)!
        
        // Add gesture for UILabel
        lbNamSinh.isUserInteractionEnabled = true // Remember to do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapChooseYear))
        lbNamSinh.addGestureRecognizer(tap)
    }
    
    func didTapChooseTime() {
        dropDownGio.show()
    }
    
    func didTapChooseDay() {
        dropDownNgay.show()
    }
    
    func didTapChooseMonth() {
        dropDownThang.show()
    }
    
    func didTapChooseYear() {
        dropDownYear.show()
    }
    
    

}

extension SeenFollowDateTimeViewController: SeenFollowDateTimeProtocol {
    func goToResultPage(resultDic: [String : String], arrData: [TagObject]) {
        router.navigateToResultPageWhenParseSuccess(dictionary: resultDic, arrData: arrData)
    }
    
    func showAlertError() {
        Utilities.showAlertForViewController(viewController: self, title: "Sorry!", message: "Server is mantainance. Please come back later!")
    }
    
    func showLoadingView(isShowing: Bool) {
        Utilities.showLoadingForView(view: view, isShowing: isShowing)
    }
}


