//
//  ParseHtmlByDate.swift
//  TuVi
//
//  Created by Kahn on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Kanna

class ParseHtmlByDate: NSObject {
    static let sharedInstance = ParseHtmlByDate()
    typealias CompletionHandler = (_ dicDate: [String: String], _ arrDateData: [TagObject], _ hasError: Bool) -> Void
    var arrDateData = [TagObject]()
    var dictionaryDate = [String: String]()
    var arrSection = [String]()
    var hasError = false
    
    func beginParseHtmlForDate(htmlString: String, completion: CompletionHandler) {
        arrDateData.removeAll()
        arrSection.removeAll()
        hasError = false
        
        if let doc = Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8) {
            let firstContent = doc.xpath(Constants.XPath.Path_Date_Type_1)
            if firstContent.first != nil {
                let stringSoMenh = firstContent.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                dictionaryDate[Constants.Key.kVanMenh] = stringSoMenh
            } else {
                hasError = true
            }
            
            // Get data for two page at last
            var arrFont = [String]()
            var arrContentFont = [String]()
            for contentFont in doc.xpath(Constants.XPath.Path_Date_Type_2) {
                arrFont.append((contentFont.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
            }
            
            // Parse and format for first content
            var firstSecContent = ""
            for (index, content) in doc.xpath(Constants.XPath.Path_Date_Type_3).enumerated() {
                if index == 0 {
                    firstSecContent = content.text!
                }
                if content.at_css("strong") != nil && index < 2 {
                    for titleSection in content.css("strong") {
                        if !(titleSection.text?.contains("***"))! {
                            arrSection.append((titleSection.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
                            print("strong tag: \(titleSection.text)")
                        }
                    }
                    
                    if arrSection.count > 1 {
                        var finalContent = content.text!
                        if index == 1 {
                            finalContent = firstSecContent + content.text!
                        }
                       startParseFirstPage(docString: (finalContent.trimmingCharacters(in: .whitespacesAndNewlines)))
                    }
                } else if index < 2 {
                    if arrSection.count == 0 {
                        arrSection = [Constants.Date_TinhCach + ":", Constants.Date_QuanHe + ":", Constants.Date_GiaDinh + ":", Constants.Date_NgheNghiep + ":" ]
                        startParseFirstPage(docString: firstSecContent.trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                } else {
                    arrContentFont.append((content.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
                }
            }
            
            // Mapping title and content for 2 page last
            if arrFont.count == 2 {
                combineArrayFont(arrFont: arrFont, arrContentFont: arrContentFont)
            } else {
                hasError = true
            }
            
            
        }
        
        completion(dictionaryDate, arrDateData, hasError)
    }
    
    func startParseFirstPage(docString: String) {
        var fullArrString = docString.components(separatedBy: arrSection[0])
        var secondPage = ""
        if fullArrString.count == 2 {
            secondPage = fullArrString[1]
        } else {
            secondPage = fullArrString[0]
        }
        
        // Make content for "tinh cach" section
        fullArrString = secondPage.components(separatedBy: arrSection[1])
        let contentTinhCach = fullArrString[0].trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "")
        let tinhcachObj = TagObject(title: Constants.Date_TinhCach, content: contentTinhCach)
        arrDateData.append(tinhcachObj)
        
        let thirdPage = fullArrString[1]
        
        // Make content for "quan he" section
        fullArrString = thirdPage.components(separatedBy: arrSection[2])
        let quanheObj = TagObject(title: Constants.Date_QuanHe, content: fullArrString[0].trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: ""))
        arrDateData.append(quanheObj)
        
        let fourPage = fullArrString[1]
        
        // Make content for "gia dinh" section
        fullArrString = fourPage.components(separatedBy: arrSection[3])
        let giadinhObj = TagObject(title: Constants.Date_GiaDinh, content: fullArrString[0].trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: ""))
        arrDateData.append(giadinhObj)
        
        let fivePage = fullArrString[1]
        
        // Make content for "nghe nghiep" section
        let nghenghiepObj = TagObject(title: Constants.Date_NgheNghiep, content: fivePage.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: ""))
        arrDateData.append(nghenghiepObj)
        
    }
    
    func combineArrayFont(arrFont: [String], arrContentFont: [String]) {
        let tagObjSec1 = TagObject(title: arrFont.first!.uppercased(), content: arrContentFont.first!.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: ""))
        let tagObjSec2 = TagObject(title: arrFont.last!.uppercased(), content: arrContentFont.last!.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: ""))
        arrDateData.append(tagObjSec1)
        arrDateData.append(tagObjSec2)
    }

}
