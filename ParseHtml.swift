//
//  ParseHtml.swift
//  TuVi
//
//  Created by Kahn on 3/14/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import Kanna

class ParseHtml: NSObject {
    static let sharedInstance = ParseHtml()
    typealias CompletionHandler = (_ resultDic: Dictionary<String, String>,_ arrData: [TagObject], _ hasError: Bool) -> Void
    var dictionary = [String: String]()
    var arrData = [TagObject]()
    var formatError = false
    
    func parseHtmlForYear(html: String, completion: CompletionHandler) {
        var finalTextParse = ""
        arrData.removeAll()
        
        formatError = false
        // Expose html string
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            // Start loop for parse follow year type 1
            
            for (index, content) in doc.xpath(Constants.XPath.Path_Year_Type_1).enumerated() {
            
                let showString = content.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                initDataParseDictionary(showString: showString, index: index)
                
                finalTextParse = finalTextParse + showString + "\n"
                
            }
            
            // Start loop for parse follow year type 2
            var content_10 = ""
            for content in doc.xpath(Constants.XPath.Path_Year_Type_2) {
                let showString = content.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                // Format content
                let startCutIndex = showString.index(showString.startIndex, offsetBy: 2)
                let cutString = showString.substring(from: startCutIndex)
                
                content_10 = content_10 + cutString + "\n"
                finalTextParse = finalTextParse + showString + "\n"
                
            }
            
            // Int content for final key diễn tiến từng năm
            if content_10 == "" {
                formatError = true
            }
            let lastTagObject = TagObject(title: Constants.localize.Title_Section_Year_10, content: content_10)
            arrData.append(lastTagObject)
            
        }
        
        // Finish parse and format content html => call completion
        print("All content html:\(finalTextParse)")
        completion(dictionary, arrData, formatError)
    }
    
    func initDataParseDictionary(showString: String, index: Int) {
        switch index {
        case 0 :
            formatFirstContentModeYear(doc: showString)
            break
        case 1 :
            formatSecondContentModeYear(doc: showString)
            break
        case 2 :
            formatThirdContentModeYear(doc: showString)
            break
        default:
            formatContentForSection(doc: showString)
            break
        }
    }
    
    
    func formatFirstContentModeYear(doc: String) {
        var fullStringArr = doc.components(separatedBy: ":")
        
        // Data valid
        if fullStringArr.count == 3 {
            // Init format content for "Tuổi"
            dictionary[Constants.Key.kTuoi] = fullStringArr[0]
            
            // Get data for key "Sinh Năm"
            let namString = fullStringArr[2].components(separatedBy: CharacterSet.decimalDigits.inverted)
            var sanhNamArr = [String]()
            for nam in namString {
                if nam != "" {
                    sanhNamArr.append(nam)
                }
            }
            let finalNamSinh = sanhNamArr.joined(separator: " - ")
            dictionary[Constants.Key.kSanhNam] = finalNamSinh
        } else {
            // Content error format
            formatError = true
        }
        
    }
    
    func formatSecondContentModeYear(doc: String) {
//        var firstStringArr = doc.components(separatedBy: " Khắc ")
//        
//        // Data valid
//        if firstStringArr.count == 2 {
//            // Cut string for "Mạng" key
//            let start = firstStringArr[0].index(firstStringArr[0].startIndex, offsetBy: 5)
//            
//            let mangString = firstStringArr[0].substring(from: start)
//            dictionary[Constants.Key.kMang] = mangString
//            print("Mạng : \(mangString)")
//            
//            // String for key "Khắc" & "Con Nhà"
//            var secondStringArr = firstStringArr[1].components(separatedBy: " Con nhà ")
//            if secondStringArr.count == 2 {
//                dictionary[Constants.Key.kKhacSo] = secondStringArr[0]
//                dictionary[Constants.Key.kConNha] = secondStringArr[1]
//            } else {
//                formatError = true
//            }
//        } else {
//            formatError = true
//        }
        if doc != "" {
            // Cut string for key "Mạng"
            let startSection = doc.index(doc.startIndex, offsetBy: 5)
            
            let contentString = doc.substring(from: startSection)
            dictionary[Constants.Key.kMang] = contentString
        } else {
            formatError = true
        }
        
    }
    
    func formatThirdContentModeYear(doc: String) {
        var fullStringArr = doc.components(separatedBy: ".")
        
        if fullStringArr.count == 2 {
            // Cut string for "Xương" key
            let startXuong = fullStringArr[0].index(fullStringArr[0].startIndex, offsetBy: 6)
            
            let xuongString = fullStringArr[0].substring(from: startXuong)
            dictionary[Constants.Key.kXuong] = xuongString
            
            // Cut string for "Tướng Tinh" key
            let startTuongTinh = fullStringArr[1].index(fullStringArr[1].startIndex, offsetBy: 12)
            
            let tuongTinhString = fullStringArr[1].substring(from: startTuongTinh)
            dictionary[Constants.Key.kTuongTinh] = tuongTinhString
        } else {
            formatError = true
        }
    }
    
    
    func formatContentForSection(doc: String) {
        // Normal case
        if doc != "" {
            var fullStringArr = doc.components(separatedBy: ": ")
            if fullStringArr.count >= 2 {
                let titleString = fullStringArr[0]
                if titleString[0] == "+" {
                    // Abnormal case
                    let lastTagObj = arrData.last
                    let nextContent = doc.substring(from: 2)
                    lastTagObj?.contentString = (lastTagObj?.contentString)! + "\n" + nextContent
                } else {
                    let title_section = titleString.uppercased()
                    
                    let firstString = title_section + ": "
                    // Init object for each sectioc: content
                    let startSection = doc.index(doc.startIndex, offsetBy: firstString.characters.count)
                    let contentString = doc.substring(from: startSection)
                    let tagSection = TagObject(title: title_section, content: contentString)
                    arrData.append(tagSection)
                }
            }
        }
    }
    
}
