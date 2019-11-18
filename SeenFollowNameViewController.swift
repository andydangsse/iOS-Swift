//
//  SeenFollowNameViewController.swift
//  TuVi
//
//  Created by Le Thanh Tan on 3/21/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Alamofire


protocol SeenFollowNameProtocol: class {
    func goToResultPage(arrData: [TagObject])
    func showLoadingView(isShowing: Bool)
    func showAlertError()
}

class SeenFollowNameViewController: BaseViewController {
    @IBOutlet weak var tfHoTen: UITextField!
    var router: SeenFollowNameRouter!
    var seenFollowNameViewModel = SeenFollowNameViewModel()
    var shouldShowFullAds = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init router
        router = SeenFollowNameRouter(seenFollowNameVC: self)
        
        // Init view model
        seenFollowNameViewModel.seenFollowName = self
        
        // Add tap gesture for self to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        
        view.addGestureRecognizer(tap)
        
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
                    RevmobHelper.share.showLoadedFullscreen()
                }
            }
        }
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToResultPage(_ sender: UIButton) {
        if let hoten = tfHoTen.text, Utilities.isValidText(inputName: hoten) {
          self.showLoadingView(isShowing: false)
          seenFollowNameViewModel.startGetAndParseHtml(hoten: hoten, completion: { (error: NSError?, data: [String : Any]?) in
            DispatchQueue.main.async {
              self.showLoadingView(isShowing: false)
              if error != nil {
                // has error
                self.showAlertError()
              } else {
                self.goToResultPage(arrData: data!["arrData"] as! [TagObject])
              }
            }
          })
        } else {
            Utilities.showAlertForViewController(viewController: self, title: "", message: "Xin vui lòng nhập tên bạn!")
        }      
    }
    
    
    func dismissKeyBoard() {
        tfHoTen.resignFirstResponder()
    }
    
    deinit {
        print("controller deinit")
    }

}

extension SeenFollowNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfHoTen.resignFirstResponder()
        
        return true
    }
}

extension SeenFollowNameViewController: SeenFollowNameProtocol {
    func goToResultPage(arrData: [TagObject]) {
        router.navigateWhenSeenBySuccessNameWithString(arrData: arrData)
    }
    
    func showLoadingView(isShowing: Bool) {
        Utilities.showLoadingForView(view: view, isShowing: isShowing)
    }
    
    func showAlertError() {
        Utilities.showAlertForViewController(viewController: self, title: "Sorry!", message: "Server is mantainance. Please come back later!")
    }
}


