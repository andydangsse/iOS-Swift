//
//  APIRequest.swift
//  TuVi
//
//  Created by Kahn on 3/14/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Alamofire

class APIRequest: NSObject {
    static let sharedInstance = APIRequest()
    typealias CompletionHandler = (_ htmlString: String, _ isSuccess: Bool) -> Void
    
    func scrapingDataFromServer(url: String, params: Parameters, completion: @escaping CompletionHandler) {
        Alamofire.request(url, method: .post, parameters: params).response { (response) in
            print("Error : \(response.error)")
            if response.error == nil {
                if let html = response.data {
                    let convertedData = String(data: html, encoding: .utf8)
                    completion(convertedData!, true)
                } else {
                    completion("", false)
                }
            } else {
                completion("", false)
            }
            
        }

    }
}
