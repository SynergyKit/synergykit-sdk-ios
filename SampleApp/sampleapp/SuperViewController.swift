//
//  SuperViewController.swift
//  homeservant
//
//  Created by Jan Čislinský on 27/11/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController
{
    var viewWidth : CGFloat {
        if let width = self.navigationController?.navigationBar.frame.size.width
        {
            return width
        }
        return self.view.frame.size.width
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view = UIView(frame: CGRectMake(0.0, 0.0, viewWidth, ScreenSize.SCREEN_HEIGHT-UIApplication.sharedApplication().statusBarFrame.size.height-navigationController!.navigationBar.frame.size.height))
        view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.translucent = false
        
//        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func divider(lastView y : UIView) -> CALayer
    {
        let divider = CALayer()
        divider.frame = CGRectMake(0.0, 0.0, viewWidth, CGRectGetMaxY(y.frame)+Dimensions.MARGIN_LEFT)
        divider.backgroundColor = UIColor(white: 0.96, alpha: 1.0).CGColor
        
        return divider
    }
}
