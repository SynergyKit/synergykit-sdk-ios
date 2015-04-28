//
//  EmailsViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 02/01/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class EmailsViewController: SuperViewController, UITextFieldDelegate {
    
    var textField : UITextField!
    var textView : UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "E-mails"
        setupContent()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        // Save textView text for this session
        NSUserDefaults.standardUserDefaults().setObject(textView.text, forKey: "NotificationTextViewContent")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        // Send notification
        textField = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, round(contentWidth*0.65)-5.0, 44.0))
        
        textField.delegate = self
        textField.placeholder = "Text of e-mail"
        
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
        
        textView.text = "You need to be Signed In."
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
                HUD.showUIBlockingIndicatorWithText("Sending…")
                
                SynergykitUser()._id(userId).fetch {
                    (result : SResponse!) -> Void in
                    
                    if result.succeeded()
                    {
                        let user = result.result as! SynergykitUser
                        if !user.email.isEmpty
                        {
                            SEmail().to(user).templateName("e-mail-example").subject("Synergykit E-mail").args(["text": self.textField.text]).send {
                                (result : SResponse!) -> Void in
                                HUD.hideUIBlockingIndicator()
                                if result.succeeded()
                                {
                                    self.textView.text = "E-mail was send to " + user.email + "."
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
                            self.textView.text = "User has not e-mail address."
                            HUD.hideUIBlockingIndicator()
                        }
                    }
                    else
                    {
                        self.textView.text = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                        HUD.hideUIBlockingIndicator()
                    }
                }
            }
            else
            {
                self.textView.text = "Error: Sign In first!"
            }
        }
        else
        {
            self.textView.text = "Type something!"
        }
    }
    
}
