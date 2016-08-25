//
//  CartViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/24.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "CartCell"


class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configView()
    }

    func configView()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        
        
        tableView.registerNib(UINib(nibName: "CartTableViewCell",bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  //   MARK -- tableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! CartTableViewCell
        cell.selectionStyle = .None
        return cell
    }
    
    
    //   MARK -- tableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}
