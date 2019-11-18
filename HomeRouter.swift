//
//  HomeRouter.swift
//  TuVi
//
//  Created by KhoaND12 on 3/15/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class HomeRouter {
    weak var viewController: HomeViewController!
    
    init(homeVC: HomeViewController) {
        self.viewController = homeVC
    }
    
    func navigateWhenSeenByYear() {
        // NOTE: Teach the router how to navigate to another scene:
        
        // 1. Get predict view controller
        let mainStoryboard = Constants.StoryBoard.main
        let tuviByYearViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.seenByYear)
        
        // 2. Ask the navigation controller to push another view controller onto the stack
        viewController.navigationController?.pushViewController(tuviByYearViewController, animated: true)
    }
    
    func navigateWhenSeenByName() {
        // NOTE: Teach the router how to navigate to another scene:
        
        // 1. Get predict view controller
        let mainStoryboard = Constants.StoryBoard.main
        let tuviByNameViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.seenByName)
        
        // 2. Ask the navigation controller to push another view controller onto the stack
        viewController.navigationController?.pushViewController(tuviByNameViewController, animated: true)
    }
    
    func navigateWhenSeenByDate() {
        // NOTE: Teach the router how to navigate to another scene:
        
        // 1. Get predict view controller
        let mainStoryboard = Constants.StoryBoard.main
        let tuviByDateViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.seenByDate)
        
        // 2. Ask the navigation controller to push another view controller onto the stack
        viewController.navigationController?.pushViewController(tuviByDateViewController, animated: true)
    }
    
    func navigateToHocTuVi() {
        // NOTE: Teach the router how to navigate to another scene:
        
        // 1. Get predict view controller
        let mainStoryboard = Constants.StoryBoard.main
        let hocTuViViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.hocTuVi)
        
        // 2. Ask the navigation controller to push another view controller onto the stack
        viewController.navigationController?.pushViewController(hocTuViViewController, animated: true)
    }
}
