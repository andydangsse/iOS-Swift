//
//  TagObject.swift
//  TuVi
//
//  Created by Le Thanh Tan on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class TagObject: NSObject {
    var titleString: String?
    var contentString: String?
    
    init(title: String, content: String) {
        self.contentString = content
        self.titleString = title
    }

}
