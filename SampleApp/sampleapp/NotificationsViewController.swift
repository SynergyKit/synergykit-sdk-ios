//
//  NotificationsViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 02/01/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class NotificationsViewController: SuperViewController, UITextFieldDelegate {

    var textField : UITextField!
    var textView : UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Notifications"
        setupContent()
        
        // Register for delegation
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.notificationController = self
    }
    
    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        // Send notification
        textField = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, round(contentWidth*0.65)-5.0, 44.0))
        
        textField.delegate = self
        textField.placeholder = "Text of notification"
        
        let sendButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT+round(contentWidth*0.65)+5.0, marginTop, round(contentWidth*0.35)-5.0, 44.0))

        sendButton.addTarget(self, action: "sendButtonPress:", forControlEvents: .TouchUpInside)
        sendButton.setTitle("Send", forState: .Normal)
        
        let divider = self.divider(lastView: sendButton)
        view.layer.addSublayer(divider)
        
        view.addSubview(textField)
        view.addSubview(sendButton)

        let height : CGFloat = view.frame.size.height-CGRectGetMaxY(divider.frame)-2*Dimensions.MARGIN_LEFT
        
        textView = TextView(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(divider.frame)+Dimensions.MARGIN_LEFT, contentWidth, height))
        view.addSubview(textView)
        
        textView.text = "You need to be Signed In, then received notifications will be here!"
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return true
    }
    
    func sendButtonPress(sender : UIButton)
    {
        if count(textField.text) > 0
        {
            view.endEditing(true)
            
            if let userId = NSUserDefaults.standardUserDefaults().objectForKey(StaticStrings.USER_ID) as? String
            {
                HUD.showUIBlockingIndicator()
                
                // Send notification
                SNotification(recipient: SynergykitUser()._id(userId)).alert(textField.text).send {
                    (result : SResponse!) -> Void in
                    HUD.hideUIBlockingIndicator()
                    if result.succeeded()
                    {
                        self.textView.text = "Notification Sended, wait a sec!"
                        self.textField.text = ""
                    }
                    else
                    {
                        self.textView.text = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                    }
                }
            }
            else
            {
                let string = "Error: Sign In first!"
                self.textView.text = string
            }
        }
        else
        {
            self.textView.text = "Type something!"
        }
    }
    
    func receivedNotification(userInfo: [NSObject : AnyObject])
    {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm:ss"
        let string = dateFormatter.stringFromDate(NSDate()) + "  " + ((userInfo["aps"] as! [NSObject : AnyObject])["alert"] as! String)
        self.textView.text = string + "\n" + self.textView.text
    }



}
