//
//  ResultPageNameViewController.swift
//  TuVi
//
//  Created by Kahn on 3/23/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit


class ResultPageNameViewController: BaseViewController {

    @IBOutlet weak var tableViewResult: UITableView!
    var arrData = [TagObject]()
    let normalCell = "normalCell"
    let headerCellId = "headerCellCustom"


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewResult.delegate = self
        tableViewResult.dataSource = self
        
        tableViewResult.rowHeight = UITableViewAutomaticDimension
        tableViewResult.estimatedRowHeight = 140
        tableViewResult.contentInset = UIEdgeInsets.zero
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        let nibNameHeader = UINib(nibName: "CustomHeaderCell", bundle:nil)
        tableViewResult.register(nibNameHeader, forCellReuseIdentifier: headerCellId)
       

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
    
    @IBAction func backToNameScreen(_ sender: UIButton) {
         _ = navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("controller deinit")
    }

}

extension ResultPageNameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellId) as! CustomHeaderCell
        
        headerCell.lbNumberStatus.text = String(section + 1)
        headerCell.lbSectionTitle.text = arrData[section].titleString
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

extension ResultPageNameViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: normalCell)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: normalCell)
        }
        cell?.textLabel?.text = arrData[indexPath.section].contentString
        cell?.textLabel?.lineBreakMode = .byWordWrapping
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell!
    }
}


