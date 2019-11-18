//
//  HomeViewController.swift
//  TuVi
//
//  Created by Kahn on 3/14/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var btnTuViFollowName: UIButton!
    @IBOutlet weak var btnTuViFollowDate: UIButton!
    
    @IBOutlet weak var viewContainButton: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnTuViFollowYear: UIButton!
    @IBOutlet weak var btnTuViTuongSo: UIButton!
    @IBOutlet weak var btnTuViHotGame: UIButton!
    
    var router: HomeRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        // init router
        router = HomeRouter(homeVC: self)
        
        // Init button layout
        viewContainButton.transform = viewContainButton.transform.rotated(by: -CGFloat(M_PI_4))
        
        Utilities.configForButton(button: btnTuViFollowName)
        Utilities.configForButton(button: btnTuViFollowDate)
        Utilities.configForButton(button: btnTuViFollowYear)
        Utilities.configForButton(button: btnTuViTuongSo)
        
        
    }
    override func viewDidLayoutSubviews() {
        setBoldSizeForTitleBtn(button: btnTuViFollowDate)
        setBoldSizeForTitleBtn(button: btnTuViFollowYear)
        setBoldSizeForTitleBtn(button: btnTuViFollowName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBoldSizeForTitleBtn(button: UIButton) {
        button.titleLabel?.attributedText = Utilities.attributedString(from: (button.titleLabel)!, nonBoldRange: NSMakeRange(0, 10))
    }
    
    @IBAction func seenTuViByNameClicked(_ sender: UIButton) {
        router.navigateWhenSeenByName()
    }
    
    @IBAction func seenTuViByDateClicked(_ sender: UIButton) {
        router.navigateWhenSeenByDate()
    }
    
    @IBAction func seenTuViByYearClicked(_ sender: UIButton) {
        router.navigateWhenSeenByYear()
    }
    
    @IBAction func tuViTuongSoClicked(_ sender: UIButton) {
        router.navigateToHocTuVi()
    }
    
    @IBAction func hotGameClicked(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: Constants.UrlIdentifier.urlForHotGame)!)
    }
}

