//
//  ParseHtmlByDateTime.swift
//  TuVi
//
//  Created by Kahn on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Kanna

class ParseHtmlByTime: NSObject {
    static let sharedInstance = ParseHtmlByTime()
    typealias CompletionHandler = (_ dicTime: [String: String], _ arrTimeData: [TagObject], _ hasError: Bool) -> Void
    var arrTimeData = [TagObject]()
    var dictionaryTime = [String: String]()
    var dataSection = [String]()
    var dataContent = [String]()
    var hasError = false
    
    func beginParseHtmlForTime(htmlString: String, completion: CompletionHandler) {
        arrTimeData.removeAll()
        dataSection.removeAll()
        dataContent.removeAll()
        hasError = false
        
        if let doc = Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8) {
            // Step 1 parse and formay for dictionnary first cell in table view
            for (index, content) in doc.xpath(Constants.XPath.Path_Time_Type_1).enumerated() {
                let showString = content.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                if index == 1 {
                    dictionaryTime[Constants.Key.kGioSinh] = showString
                } else if index == 2 {
                    dictionaryTime[Constants.Key.kViTriSinh] = showString
                } else if index == 3 {
                    break
                }
            }
            
            // Step parse 2 for key "Bình Giải"
            let contentString = doc.xpath(Constants.XPath.Path_Time_Type_2)
            let showString = contentString.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if let showString = showString {
                let firstTag = TagObject(title: Constants.localize.Title_Time_First, content: showString)
                arrTimeData.append(firstTag)
            } else {
                hasError = true
            }
            
            
            // Step 3 parse for under table of time
            for (index, content) in doc.xpath(Constants.XPath.Path_Time_Type_3).enumerated() {
                if  index == 0 {
                    formatForSectionTable(doc: content)
                } else if index == 1 {
                    formatForContentTable(doc: content)
                } else {
                    print("wrong")
                    hasError = true
                }
                print("content : \(content.text)")
            }
            
            
            // Combine two array section and content
            if dataContent.count != dataSection.count || dataSection.count == 0 || dataContent.count == 0 {
                hasError = true
            } else {
                combineTwoArray()
            }
        }
        
        completion(dictionaryTime, arrTimeData, hasError)
    }
    
    func formatForSectionTable(doc: XMLElement) {
        for title in doc.xpath("td") {
            let titleString = title.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            dataSection.append(titleString!.uppercased())
        }
    }
    
    func formatForContentTable(doc: XMLElement) {
        for content in doc.xpath("td") {
            let show = content.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let contentString = show?.replacingOccurrences(of: "\t", with: "")
            dataContent.append(contentString!)
        }
    }
    
    func combineTwoArray() {
        for i in 0..<dataContent.count {
            let tagObj = TagObject(title: dataSection[i], content: dataContent[i])
            arrTimeData.append(tagObj)
        }
    }
}
