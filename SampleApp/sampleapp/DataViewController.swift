//
//  DataViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 29/12/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class DataViewController: SuperViewController, UITextFieldDelegate {

    let COLLECTION_NAME = "demo-objects"
    
    var textField : UITextField!
    var textView : UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Data"
        
        setupContent()
    }
    
    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        // POST
        textField = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, round(contentWidth*0.65)-5.0, 44.0))
        
        textField.delegate = self
        textField.placeholder = "Insert some text"
        
        let postButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT+round(contentWidth*0.65)+5.0, marginTop, round(contentWidth*0.35)-5.0, 44.0))
        
        postButton.addTarget(self, action: "postButtonPress:", forControlEvents: .TouchUpInside)
        postButton.setTitle("POST data", forState: .Normal)
        
        let divider = self.divider(lastView: postButton)
        view.layer.addSublayer(divider)
        
        view.addSubview(textField)
        view.addSubview(postButton)
        
        // GET
        let getButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, view.frame.size.height-60.0, contentWidth, 44.0))
        view.addSubview(getButton)
        
        getButton.addTarget(self, action: "getButtonPress:", forControlEvents: .TouchUpInside)
        getButton.setTitle("GET data", forState: .Normal)
        
        let height : CGFloat = CGRectGetMinY(getButton.frame)-CGRectGetMaxY(divider.frame)-2*Dimensions.MARGIN_LEFT

        textView = TextView(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(divider.frame)+Dimensions.MARGIN_LEFT, contentWidth, height))
        view.addSubview(textView)
        
        textView.text = "At first post some data."
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return true
    }
    
    func postButtonPress(sender : UIButton)
    {
        if count(textField.text) > 0
        {
            HUD.showUIBlockingIndicatorWithText("Posting…")
            view.endEditing(true)
            
            // POST new data to collection
            var post = DemoObject(collection: COLLECTION_NAME)
            post.text = textField.text

            post.save {
                (result : SResponse!) -> Void in
                if !result.succeeded()
                {
                    self.textView.text = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                }
                else
                {
                    // Update content of textView
                    self.textField.text = ""
                    
                    let object = result.result as! DemoObject
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd HH:mm:ss"
                    let date = NSDate(timeIntervalSince1970: Double(object.createdAt!.integerValue/1000))

                    self.textView.text = dateFormatter.stringFromDate(date) + "  " + (object.text != nil ? object.text : "–")
                }
                HUD.hideUIBlockingIndicator()
            }
        }
        else
        {
            self.textView.text = "Type something!"
        }
    }
    
    func getButtonPress(sender : UIButton?)
    {
        HUD.showUIBlockingIndicatorWithText("Getting…")
        
        // Download all data from collection
        SQuery(object: DemoObject(collection: COLLECTION_NAME)).orderBy("createdAt", direction: .Desc).top(10).find {
            (result : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            if !result.succeeded()
            {
                var errors = ""
                for error in result.errors() as! [NSError]
                {
                    errors += ((error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String) + "\n"
                }
                self.textView.text = errors
            }
            else
            {
                var finalString = ""
                for object in result.results() as! [DemoObject]
                {
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd HH:mm:ss"
                    let date = NSDate(timeIntervalSince1970: Double(object.createdAt!.integerValue/1000))
                    let string = dateFormatter.stringFromDate(date) + "  " + (object.text != nil ? object.text : "–")
                    finalString += string + "\n"
                }
                self.textView.text = finalString
            }
            
        }
    }
}
