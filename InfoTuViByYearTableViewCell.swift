//
//  InfoTuViByYearTableViewCell.swift
//  TuVi
//
//  Created by Kahn on 3/17/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class InfoTuViByYearTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTuoi: UILabel!
    @IBOutlet weak var lbSinhNam: UILabel!
    @IBOutlet weak var lbMang: UILabel!
    @IBOutlet weak var lbXuong: UILabel!
    @IBOutlet weak var lbTuongTinh: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTextForLabelWith(cell: InfoTuViByYearTableViewCell, dictionary: [String: String]) {
        cell.lbTuoi.text = dictionary[Constants.Key.kTuoi]!
        cell.lbMang.text = dictionary[Constants.Key.kMang]!
        cell.lbXuong.text = dictionary[Constants.Key.kXuong]!
        cell.lbSinhNam.text = dictionary[Constants.Key.kSanhNam]!
        cell.lbTuongTinh.text = dictionary[Constants.Key.kTuongTinh]!
    }

}
