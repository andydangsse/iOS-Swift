//
//  SeenFollowNameViewModel.swift
//  TuVi
//
//  Created by Le Thanh Tan on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Alamofire

class SeenFollowNameViewModel: NSObject {
  weak var seenFollowName: SeenFollowNameProtocol!
    
  func startGetAndParseHtml(hoten: String, completion: @escaping (_ error: NSError?, _ data: [String : Any]?) -> Void) {
        let param: Parameters = [Constants.Key.Param_Hoten: hoten, Constants.Key.Param_XemBoiAiCap: ""]
        seenFollowName.showLoadingView(isShowing: true)
        APIRequest.sharedInstance.scrapingDataFromServer(url: Constants.UrlIdentifier.urlForName,
                                                         params: param) { (result, isSuccess) in
            if isSuccess {
                ParseHtmlByName.sharedInstance.beginParseHtmlForName(html: result,
                                                                     completion: { (arrData, hasError) in
                  if hasError {
                    // has error
                    completion(NSError(domain: Constants.Key.kDomainName,
                                       code: 0,
                                       userInfo: nil), nil)
                  } else {
                    completion(nil, ["arrData" : arrData])
                  }
                })
            } else {
              completion(NSError(domain: Constants.Key.kDomainName, code: 0, userInfo: nil), nil)
            }
        }
    }
}
