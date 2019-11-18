//
//  Utilities.swift
//  TuVi
//
//  Created by Le Thanh Tan on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit
import MBProgressHUD

class Utilities: NSObject {
    class func setBorderForLabel(label: UILabel) {
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.cornerRadius = 5
    }
    
    class func isValidText(inputName: String) -> Bool {    
        if inputName.characters.count > 0 {
            return true
        }
        return false
    }
    
    class func isValidForShowFullAds() -> Bool {
        let randomNum = arc4random_uniform(101)
        print("random number: \(randomNum)")
        if 0...30 ~= randomNum {
            return true
        } else {
            return false
        }
    }
    
    class func setLineBreakForButton(btn: UIButton) {
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.textAlignment = .center
    }
    
    class func showLoadingForView(view: UIView, isShowing: Bool) {
        if isShowing {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .indeterminate
            hud.show(animated: true)
        } else {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    class func showAlertForViewController(viewController: BaseViewController, title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            viewController.dismiss(animated: false, completion: nil)
        }))
        
        // show the alert
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func configForButton(button: UIButton) {
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        
        button.titleLabel?.transform = (button.titleLabel?.transform.rotated(by: CGFloat(M_PI_4)))!
    }
    
    class func attributedString(from label: UILabel, nonBoldRange: NSRange?) -> NSAttributedString {
        let string = label.text!
        let fontSize = label.font.pointSize
        let attrs = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize),
            NSForegroundColorAttributeName: UIColor.white
        ]
        let nonBoldAttribute = [
            NSFontAttributeName: UIFont.systemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
}
