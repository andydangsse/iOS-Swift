//
//  SeenFollowYearViewModel.swift
//  TuVi
//
//  Created by Le Thanh Tan on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Alamofire

class SeenFollowYearViewModel: NSObject {
    weak var seenFollowYear: SeenFollowYearProtocol!
    
    func startGetDataFromApi(year: Int, sex: Int) {
        let params: Parameters = [Constants.Key.Param_Year: year, Constants.Key.Param_Sex: sex, Constants.Key.Param_TuViTronDoi: ""]
        seenFollowYear.showLoadingView(isShowing: true)
        APIRequest.sharedInstance.scrapingDataFromServer(url: Constants.UrlIdentifier.urlForYear, params: params) { (htmlString, isSuccess) in
            if isSuccess {
                ParseHtml.sharedInstance.parseHtmlForYear(html: htmlString, completion: { (resultDic, arrData, hasError) in
                    DispatchQueue.main.async {
                        self.seenFollowYear.showLoadingView(isShowing: false)
                        if !hasError {
                            self.seenFollowYear.goToResultPage(resultDic: resultDic, arrData: arrData)
                        } else {
                            // Show alert error
                            self.seenFollowYear.showAlertError()
                        }
                    }
                })
            } else {
                // Show alert error
                DispatchQueue.main.async {
                    self.seenFollowYear.showLoadingView(isShowing: false)
                    // Show alert
                    self.seenFollowYear.showAlertError()
                }
            }
        }
    }
}
