//
//  MainViewController.swift
//  homeservant
//
//  Created by Jan Čislinský on 27/11/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class MainViewController: SuperViewController, UITableViewDataSource, UITableViewDelegate {
    
    // #############################################################################
    // MARK: Properties
    
    var tableView : UITableView?
    var lastSelectedIndexPath : NSIndexPath?
    var menuTitles = ["Sign Up", "Sign In", "Data", "Queries", "Files", "Cloud Code", "Notifications", "E-mails", "Batch", "Chat", "How to use cache"]
    var menuClasses : [UIViewController.Type] = [SignUpViewController.self, SignInViewController.self, DataViewController.self, QueriesViewController.self, FilesViewController.self, CloudCodeViewController.self, NotificationsViewController.self, EmailsViewController.self, BatchViewController.self, ChatViewController.self, CacheViewController.self]
    
    // #############################################################################
    // MARK: View Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupContent()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if let indexPath = lastSelectedIndexPath
        {
            tableView?.deselectRowAtIndexPath(indexPath, animated: true)
            lastSelectedIndexPath = nil
        }
    }
    
    // #############################################################################
    // MARK: GUI
    
    func setupContent()
    {
        let logoButton = UIButton(frame: CGRectMake(0.0, 0.0, 115.0, 25.0))
        logoButton.setImage(UIImage(named: "navbar-logo"), forState: .Normal)
        logoButton.setImage(UIImage(named: "navbar-logo-pressed"), forState: UIControlState.Highlighted)
        logoButton.addTarget(self, action: "synergykitPress:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = logoButton
        
        // TableView
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView!)
        
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        tableView!.tableFooterView = UIView()
    }
    
    func synergykitPress(sender : UIButton)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://synergykit.com?utm_source=app&utm_medium=synergykit-sample-app-ios&utm_campaign=footer-tableview-logo")!)
    }
    
    // #############################################################################
    // MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdent = "Cell"
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdent) as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdent)
        }
        
        cell.textLabel!.text = menuTitles[indexPath.row]
        cell.textLabel!.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuTitles.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        lastSelectedIndexPath = indexPath
        let type = menuClasses[indexPath.row]
        let controller = type()
        
        navigationController!.pushViewController(controller, animated: true)
    }
}
