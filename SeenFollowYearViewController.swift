//
//  SeenFollowYearViewController.swift
//  TuVi
//
//  Created by Kahn on 3/14/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import DropDown
import DLRadioButton
import Alamofire


protocol SeenFollowYearProtocol: class {
    func goToResultPage(resultDic: [String: String], arrData: [TagObject])
    func showLoadingView(isShowing: Bool)
    func showAlertError()
}

class SeenFollowYearViewController: BaseViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var btnMaleSex: UIButton!
    @IBOutlet weak var btnFemaleSex: UIButton!
    @IBOutlet weak var btnSeen: UIButton!
    @IBOutlet weak var imgMaleSelect: UIImageView!
    @IBOutlet weak var imgFemaleSelect: UIImageView!
    var yearArr = [String]()
    var sex = Constants.Male_Sex
    var yearSelected = 0
    let dropDown = DropDown()
    var seenFollowYearViewModel = SeenFollowYearViewModel()
    var router: SeenFollowYearRouter!
    

    var shouldShowFullAds = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Setup for drop down list show year for choose
        createArrayForYear()
        dropDown.anchorView = lbYear
        dropDown.dataSource = yearArr
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            self.yearSelected = Int(self.yearArr[index])!
            self.lbYear.text = item
            print("Selected item: \(item) at index: \(index)")
        }
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectRow(at: 30)
        lbYear.text = dropDown.selectedItem
        yearSelected = Int(dropDown.selectedItem!)!

        
        // Add gesture for UILabel
        lbYear.isUserInteractionEnabled = true // Remember to do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapChooseYear))
        lbYear.addGestureRecognizer(tap)
        
        // Init View Model
        seenFollowYearViewModel.seenFollowYear = self
        
        // Init router
        router = SeenFollowYearRouter(seenFollowYearVC: self)
        
        // Setup layout button
        imgFemaleSelect.isHidden = true
        imgMaleSelect.isHidden = false
        
        //pre-load ads
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
                    //interstitial = createAndLoadInterstitial()
                   // AdmobHelper.share.adsIsReady(viewController: self)
                    RevmobHelper.share.showLoadedFullscreen()
                }
            }
        }
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
    
    func didTapChooseYear() {
        dropDown.show()
    }

    @IBAction func clickSeenTuViFollowYear(_ sender: UIButton) {
        seenFollowYearViewModel.startGetDataFromApi(year: yearSelected, sex: sex)
    }
    
    @IBAction func chooseMaleSex(_ sender: UIButton) {
        print("Male chosen")
        sex = Constants.Male_Sex
        btnMaleSex.setBackgroundImage(UIImage(named: "ico-boy-selected"), for: .normal)
        btnFemaleSex.setBackgroundImage(UIImage(named: "ico-girl-unselect"), for: .normal)
        imgMaleSelect.isHidden = false
        imgFemaleSelect.isHidden = true
    }
        
    @IBAction func chooseFemaleSex(_ sender: UIButton) {
        print("Female chosen")
        sex = Constants.Female_Sex
        btnMaleSex.setBackgroundImage(UIImage(named: "ico-boy-unselect"), for: .normal)
        btnFemaleSex.setBackgroundImage(UIImage(named: "ico-girl-selected"), for: .normal)
        imgMaleSelect.isHidden = true
        imgFemaleSelect.isHidden = false
    }

    @IBAction func backToHome(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    deinit {
        print("controller deinit")
    }
}

extension SeenFollowYearViewController: SeenFollowYearProtocol {
    func goToResultPage(resultDic: [String: String], arrData: [TagObject]) {
        router.navigateWhenSeenByYearSuccessWithString(resultDic: resultDic, arrData: arrData)
    }
    
    func showLoadingView(isShowing: Bool) {
        Utilities.showLoadingForView(view: view, isShowing: isShowing)
    }
    
    func showAlertError() {
        Utilities.showAlertForViewController(viewController: self, title: "Sorry!", message: "Server is mantainance. Please come back later!")
    }
}

