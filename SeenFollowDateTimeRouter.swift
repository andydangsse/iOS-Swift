//
//  SeenFollowDateTime.swift
//  TuVi
//
//  Created by Kahn on 3/24/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class SeenFollowDateTimeRouter {
    weak var viewController: SeenFollowDateTimeViewController!
    
    init(seenFollowDateTimeVC: SeenFollowDateTimeViewController) {
        self.viewController = seenFollowDateTimeVC
    }
    
    func navigateToResultPageWhenParseSuccess(dictionary: [String: String], arrData: [TagObject]) {
        // NOTE: Teach the router how to navigate to another scene:
        
        // 1. Get predict view controller
        let mainStoryboard = Constants.StoryBoard.main
        let resultViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.resultPageDateTime) as! ResultDateTimeViewController
        
        // 2. Assign result string after parse succes for this view
        resultViewController.arrData = arrData
        resultViewController.dicionaryDateTime = dictionary
        
        // 3. Ask the navigation controller to push another view controller onto the stack
        viewController.shouldShowFullAds = true
        viewController.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
}
