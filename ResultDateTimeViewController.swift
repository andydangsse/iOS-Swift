//
//  ResultDateTimeViewController.swift
//  TuVi
//
//  Created by Kahn on 3/24/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit


class ResultDateTimeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var dicionaryDateTime = [String: String]()
    var arrData = [TagObject]()
    
    let headerCellId = "headerCellCustom"
    let infoCell = "infoDateCell"
    let normalCell = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Config for table view
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.contentInset = UIEdgeInsets.zero
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibNameHeader = UINib(nibName: "CustomHeaderCell", bundle:nil)
        tableView.register(nibNameHeader, forCellReuseIdentifier: headerCellId)
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RevmobHelper.share.showBanner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RevmobHelper.share.hideBanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToPageDateTime(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}

extension ResultDateTimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellId) as! CustomHeaderCell
        if section == 0 {
            return UIView()
        } else {
            headerCell.lbNumberStatus.text = String(section)
            headerCell.lbSectionTitle.text = arrData[section - 1].titleString
            return headerCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        }
        return 40
    }
    
}

extension ResultDateTimeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrData.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCell, for: indexPath) as! CustomDateTimeTableViewCell
            if let vanmenh = dicionaryDateTime[Constants.Key.kVanMenh] {
                cell.lbSoMang.text = vanmenh
            }
            
            if let giosinh = dicionaryDateTime[Constants.Key.kGioSinh]  {
                cell.lbGioSinhDes.text = giosinh
            }
            
            if let vitri = dicionaryDateTime[Constants.Key.kViTriSinh] {
                cell.lbViTriSinh.text = vitri
            }
            
            return cell
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: normalCell)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: normalCell)
            }
            cell?.textLabel?.text = arrData[indexPath.section - 1].contentString
            cell?.textLabel?.lineBreakMode = .byWordWrapping
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
            return cell!
        }
    }
}

