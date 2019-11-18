//
//  SeenFollowYearRouter.swift
//  TuVi
//
//  Created by Le Thanh Tan on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class SeenFollowYearRouter {
    weak var viewController: SeenFollowYearViewController!
    
    init(seenFollowYearVC: SeenFollowYearViewController) {
        self.viewController = seenFollowYearVC
    }
    
    func navigateWhenSeenByYearSuccessWithString(resultDic: [String: String], arrData: [TagObject]) {
        // NOTE: Teach the router how to navigate to another scene:
        
        // 1. Get predict view controller
        let mainStoryboard = Constants.StoryBoard.main
        let resultViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.resultPage) as! ResultPageViewController
        
        // 2. Assign result string after parse succes for this view
        resultViewController.resultDic = resultDic
        resultViewController.arrData = arrData
        
        // 3. Ask the navigation controller to push another view controller onto the stack
        viewController.shouldShowFullAds = true
        viewController.navigationController?.pushViewController(resultViewController, animated: true)
    }
}
