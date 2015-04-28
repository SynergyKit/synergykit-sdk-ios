//
//  CacheViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 29/12/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class CacheViewController: SuperViewController, UITextFieldDelegate {
    
    let COLLECTION_NAME = "ios-cache-demo"
    let EXPIRATION_TIME = 20
    
    var textField : UITextField!
    var loadElseCache, loadElseCacheExpiration, cacheElseLoad, cacheElseLoadExpiration : UILabel!
//    var objects, labelArray, cacheTypeArray, cacheExpirationArray : []!
    var objects : [DemoObject]!
    var requestCounter : Int!
    
    var labelsText : String! {
        didSet {
            loadElseCache.text = self.labelsText
            loadElseCacheExpiration.text = self.labelsText
            cacheElseLoad.text = self.labelsText
            cacheElseLoadExpiration.text = self.labelsText
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Cache demo"
        
        setupContent()
        prepareDemo()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for object in objects as [DemoObject]
        {
            object.destroy(nil)
        }
    }
    
    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        let headingMarginBottom : CGFloat = DeviceType.IS_IPHONE_4_OR_LESS ? -5.0 : 0.0
        let headingMarginTop : CGFloat = DeviceType.IS_IPHONE_4_OR_LESS ? 8.0 : 15.0
        
        // POST
        textField = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, round(contentWidth*0.65)-5.0, 44.0))
        
        textField.delegate = self
        textField.placeholder = "Insert some text"
        
        let updateButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT+round(contentWidth*0.65)+5.0, marginTop, round(contentWidth*0.35)-5.0, 44.0))
        
        updateButton.addTarget(self, action: "updateButtonPress:", forControlEvents: .TouchUpInside)
        updateButton.setTitle("Update", forState: .Normal)
        
        let divider = self.divider(lastView: updateButton)
        view.layer.addSublayer(divider)
        
        view.addSubview(textField)
        view.addSubview(updateButton)
        
        var heading : Label!
        
        heading = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(divider.frame)+Dimensions.MARGIN_LEFT+headingMarginTop, contentWidth, 14.0))
        view.addSubview(heading)
        
        loadElseCache = UILabel(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(heading.frame)+headingMarginBottom, contentWidth, 44.0))
        
        heading.text = "Load else cache policy"
        loadElseCache.text = "Press Delete cache & refresh"        
        
        heading = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(loadElseCache.frame)+headingMarginTop, contentWidth, 14.0))
        view.addSubview(heading)
        
        loadElseCacheExpiration = UILabel(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(heading.frame)+headingMarginBottom, contentWidth, 44.0))
        
        heading.text = "Load else cache policy with " + String(EXPIRATION_TIME) + " s expiration"
        loadElseCacheExpiration.text = "Press Delete cache & refresh"
        
        heading = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(loadElseCacheExpiration.frame)+headingMarginTop, contentWidth, 14.0))
        view.addSubview(heading)
        
        cacheElseLoad = UILabel(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(heading.frame)+headingMarginBottom, contentWidth, 44.0))
        
        heading.text = "Cache else load policy"
        cacheElseLoad.text = "Press Delete cache & refresh"
        
        heading = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(cacheElseLoad.frame)+headingMarginTop, contentWidth, 14.0))
        view.addSubview(heading)
        
        cacheElseLoadExpiration = UILabel(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(heading.frame)+headingMarginBottom, contentWidth, 44.0))
        
        heading.text = "Cache else load policy with " + String(EXPIRATION_TIME) + " s expiration"
        cacheElseLoadExpiration.text = "Press Delete cache & refresh"
        
        loadElseCache.textAlignment = .Center
        loadElseCacheExpiration.textAlignment = .Center
        cacheElseLoad.textAlignment = .Center
        cacheElseLoadExpiration.textAlignment = .Center
        
        view.addSubview(loadElseCache)
        view.addSubview(loadElseCacheExpiration)
        view.addSubview(cacheElseLoad)
        view.addSubview(cacheElseLoadExpiration)
        
        let refreshButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, view.frame.size.height-60.0, (contentWidth-Dimensions.MARGIN_LEFT)/3.0, 44.0))
        refreshButton.addTarget(self, action: "refreshButtonPress:", forControlEvents: .TouchUpInside)
        refreshButton.setTitle("Refresh", forState: .Normal)
        
        let deleteButton = Button(frame: CGRectMake(viewWidth-Dimensions.MARGIN_LEFT-2*(contentWidth-Dimensions.MARGIN_LEFT)/3.0, view.frame.size.height-60.0, 2*(contentWidth-Dimensions.MARGIN_LEFT)/3.0, 44.0))
        deleteButton.addTarget(self, action: "deleteButtonPress:", forControlEvents: .TouchUpInside)
        deleteButton.setTitle("Delete cache & refresh", forState: .Normal)
        
        let helpButton = Button(frame: CGRectMake(viewWidth-Dimensions.MARGIN_LEFT-(contentWidth-Dimensions.MARGIN_LEFT)/3.0, view.frame.size.height-105.0, (contentWidth-Dimensions.MARGIN_LEFT)/3.0, 34.0))
        helpButton.addTarget(self, action: "helpButtonPress:", forControlEvents: .TouchUpInside)
        helpButton.setTitle("Need Help?", forState: .Normal)
        helpButton.titleLabel!.font = UIFont.boldSystemFontOfSize(12.0)

        view.addSubview(refreshButton)
        view.addSubview(deleteButton)
        view.addSubview(helpButton)
        
    }
    
    func prepareDemo()
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let n = HUD.showUIBlockingIndicatorWithText("Preparing…")
            })
            
            var errorMessage = ""

            let firstText = "First text"
            self.objects = []
            
            let demo1 = DemoObject(collection: self.COLLECTION_NAME)
            demo1.text = firstText
            
            let response1 = demo1.save()
            if !response1.succeeded()
            {
                errorMessage = (response1.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String
            }
            else
            {
                let result1 = response1.result as! DemoObject
                result1.cache = SCache(type: .LoadElseCache)
                self.objects.append(result1)
            }
            
            let demo2 = DemoObject(collection: self.COLLECTION_NAME)
            demo2.text = firstText
            
            let response2 = demo2.save()
            if !response2.succeeded()
            {
                errorMessage = (response2.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String
            }
            else
            {
                let result2 = response2.result as! DemoObject
                result2.cache = SCache(type: .LoadElseCache, expiration: self.EXPIRATION_TIME)
                self.objects.append(result2)
            }
            
            let demo3 = DemoObject(collection: self.COLLECTION_NAME)
            demo3.text = firstText
            
            let response3 = demo3.save()
            if !response3.succeeded()
            {
                errorMessage = (response3.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String
            }
            else
            {
                let result3 = response3.result as! DemoObject
                result3.cache = SCache(type: .CacheElseLoad)
                self.objects.append(result3)
            }
            
            let demo4 = DemoObject(collection: self.COLLECTION_NAME)
            demo4.text = firstText
            
            let response4 = demo4.save()
            if !response4.succeeded()
            {
                errorMessage = (response4.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String
            }
            else
            {
                let result4 = response4.result as! DemoObject
                result4.cache = SCache(type: .CacheElseLoad, expiration: self.EXPIRATION_TIME)
                self.objects.append(result4)
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                HUD.hideUIBlockingIndicator()
                
                if self.objects.count != 4
                {
                    let alert: UIAlertController = UIAlertController(title: "Error", message: "Data initialization failed, please try it again later. Error message: " + errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                        (alert : UIAlertAction!) -> Void in
                        let a = self.navigationController!.popToRootViewControllerAnimated(true)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else
                {
                    self.refreshButtonPress(nil)
                }
            })
        })
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return true
    }
    
    func updateButtonPress(sender : UIButton)
    {
        if count(textField.text) > 0
        {
            view.endEditing(true)
            HUD.showUIBlockingIndicatorWithText("Updating…")
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                var i = 0
                for object in self.objects as [DemoObject]
                {
                    object.text = self.textField.text
                    let result = object.save()
                    if result.succeeded()
                    {
                        self.objects.removeAtIndex(i)
                        self.objects.insert(result.result as! DemoObject, atIndex: i)
                    }
                    else
                    {
                        
                        let alert = UIAlertController(title: "Error", message: "Error while updating records. Error message: " + ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String), preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler:nil))
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            HUD.hideUIBlockingIndicator()
                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                        return
                    }
                    i++
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.textField.placeholder = "Updated to: " + self.textField.text
                    self.textField.text = ""
                    HUD.hideUIBlockingIndicator()
                })
            })
        }
    }
    
    
    func refreshButtonPress(sender : UIButton?)
    {
        HUD.showUIBlockingIndicatorWithText("Fetching…")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var i = 0
            for object in self.objects as [DemoObject]
            {
                let result = object.fetch()
                if result.succeeded()
                {
                    self.objects.removeAtIndex(i)
                    self.objects.insert(result.result as! DemoObject, atIndex: i)
                }
                else
                {
                    self.objects[i].text = "–" // There is no data
                }
                i++
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.printObjects()
                HUD.hideUIBlockingIndicator()
            })
        })
    }
    
    func helpButtonPress(sender : UIButton?)
    {
        let alert = UIAlertController(title: "Example flow" , message: "If you want to know, how it works try next steps:\n1) Update record with another string\n2) Refresh data\n3) Turn off internet and wait a while (for changing of reachability status)\n4) Refresh data\n5) Wait 20 seconds from last refresh\n6) Refresh data", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "I'm in", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func printObjects()
    {
        if objects.count == 4
        {
            loadElseCache.text = objects[0].text
            loadElseCacheExpiration.text = objects[1].text
            cacheElseLoad.text = objects[2].text
            cacheElseLoadExpiration.text = objects[3].text
        }
        else
        {
            labelsText = "Unknown error"
        }
    }
    
    func deleteButtonPress(sender : UIButton)
    {
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        refreshButtonPress(nil)
    }
    
}
