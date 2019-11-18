//
//  ParseHtmlByName.swift
//  TuVi
//
//  Created by Kahn on 3/21/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Kanna

class ParseHtmlByName: NSObject {
    static let sharedInstance = ParseHtmlByName()
    typealias CompletionHandler = (_ arrData: [TagObject], _ hasError: Bool) -> Void
    var arrData = [TagObject]()
    var hasError = false
    
    func beginParseHtmlForName(html: String, completion: CompletionHandler) {
        arrData.removeAll()
        hasError = false
        
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            for firstContent in doc.xpath(Constants.XPath.Path_Name_Type_1) {
                let firstTitle = firstContent.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
                let firstTag = TagObject(title: firstTitle!, content: "")
                arrData.append(firstTag)
                break
            }
            
            for (index, content) in doc.xpath(Constants.XPath.Path_Name_Type_2).enumerated() {
                formatForEachPageWith(index: index, content: content)
            }
            
        }
        print("end process")
        if (arrData.count == 0) {
            completion(arrData, true)
        } else {
            completion(arrData, false)
        }
        
        
    }
    
    func formatForEachPageWith(index: Int, content: XMLElement) {
        if content.at_css("strong") != nil {
            let titleString = content.at_css("strong")?.text?.uppercased()
            let newTagObj = TagObject(title: titleString!, content: "")
            arrData.append(newTagObj)
            // Cut title and of tag <p>
            content.removeChild(content.at_css("strong")!)
            let show = content.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let showString = show.replacingOccurrences(of: "\t", with: "")
            let previousObj = arrData[index]
            previousObj.contentString = previousObj.contentString! + showString
        } else {
            let show = content.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let contentString = show?.replacingOccurrences(of: "\t", with: "")
            let previousObj = arrData[index]
            previousObj.contentString = previousObj.contentString! + contentString!
        }
    }
    
    
}
