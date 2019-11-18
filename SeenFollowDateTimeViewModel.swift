//
//  SeenFollowDateTimeViewModel.swift
//  TuVi
//
//  Created by Kahn on 3/24/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Alamofire

class SeenFollowDateTimeViewModel: NSObject {
    weak var seenDateTimePro: SeenFollowDateTimeProtocol!
    
    func startGetAndPraseTime(gio: Int, ngay: Int, thang: Int, nam: Int) {
        // Init param for call API
        let param: Parameters = [Constants.Key.Param_Gio: gio, Constants.Key.Param_Ngay: ngay, Constants.Key.Param_Thang: thang, Constants.Key.Param_Year: nam, Constants.Key.Param_API_Gio: ""]
        
        // Show loading view
        seenDateTimePro.showLoadingView(isShowing: true)
        
        // Start call api for get html string
        APIRequest.sharedInstance.scrapingDataFromServer(url: Constants.UrlIdentifier.urlForTime, params: param) { (htmlString, isSuccess) in
            if isSuccess {
                // If success => start parse and format
                ParseHtmlByTime.sharedInstance.beginParseHtmlForTime(htmlString: htmlString, completion: { (dicTime, arrDataTime, hasError) in
                    if !hasError {
                        // If success continue parse and format for date
                        self.startGetAndParseDate(ngay: ngay, thang: thang, nam: nam, dicTime: dicTime, arrTime: arrDataTime)
                        print("Success parse and format for time")
                    } else {
                        // Show alert error fail
                        DispatchQueue.main.async {
                            self.seenDateTimePro.showLoadingView(isShowing: false)
                            self.seenDateTimePro.showAlertError()
                        }
                    }
                })
            } else {
                // Show alert error fail
                DispatchQueue.main.async {
                    self.seenDateTimePro.showLoadingView(isShowing: false)
                    self.seenDateTimePro.showAlertError()
                }
            }
        }
    }
    
    func startGetAndParseDate(ngay: Int, thang: Int, nam: Int, dicTime: [String: String], arrTime: [TagObject]) {
        // Init param for call API
        let param: Parameters = [Constants.Key.Param_Ngay: ngay, Constants.Key.Param_Thang: thang, Constants.Key.Param_Year: nam, Constants.Key.Param_API_Nam: ""]
        
        // Start call api for get html string
        APIRequest.sharedInstance.scrapingDataFromServer(url: Constants.UrlIdentifier.urlForDate, params: param) { (htmlString, isSuccess) in
            if isSuccess {
                // If success => start parse and format
                ParseHtmlByDate.sharedInstance.beginParseHtmlForDate(htmlString: htmlString, completion: { (dicDate, arrDate, hasError) in
                    DispatchQueue.main.async {
                        // Hide loading view and handle final data
                        self.seenDateTimePro.showLoadingView(isShowing: false)
                        if !hasError {
                            // If dont have any error go to result page
                            let finalDic = dicTime.merged(with: dicDate)
                            let finalArrResult = arrTime + arrDate
                            self.seenDateTimePro.goToResultPage(resultDic: finalDic, arrData: finalArrResult)
                            print("Success parse and format for date time")
                        } else {
                            // Show error
                            self.seenDateTimePro.showAlertError()
                        }
                    }
                    
                })
            } else {
                // Show alert error
                DispatchQueue.main.async {
                    self.seenDateTimePro.showLoadingView(isShowing: false)
                    self.seenDateTimePro.showAlertError()
                }
            }
        }
        
    }
}
