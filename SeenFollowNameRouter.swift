//
//  SeenFollowNameRouter.swift
//  TuVi
//
//  Created by Le Thanh Tan on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class SeenFollowNameRouter: NSObject {
    weak var viewController: SeenFollowNameViewController!
    
    init(seenFollowNameVC: SeenFollowNameViewController) {
        self.viewController = seenFollowNameVC
    }
    
    func navigateWhenSeenBySuccessNameWithString(arrData: [TagObject]) {
        // NOTE: Teach the router how to navigate to another scene:
        
        // 1. Get predict view controller
        let mainStoryboard = Constants.StoryBoard.main
        let resultViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.resultPageName) as! ResultPageNameViewController
        
        // 2. Assign result string after parse succes for this view
        resultViewController.arrData = arrData
        
        // 3. Ask the navigation controller to push another view controller onto the stack
        viewController.shouldShowFullAds = true
        viewController.navigationController?.pushViewController(resultViewController, animated: true)
    }
}
