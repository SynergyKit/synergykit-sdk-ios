//
//  QueriesViewController
//  sampleapp
//
//  Created by Jan Čislinský on 15/01/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class QueriesViewController: SuperViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate {
    
    let DOME_OBJECTS_COLLECTION = "demo-objects"
    
    var textView : UITextView!
    var fileIndex = 0;
    var lastFile : SFile?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Queries"
        setupContent()
    }
    
    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        let usersLabel = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, contentWidth, 14.0))
        usersLabel.text = "USERS"

        let lastUserButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(usersLabel.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        lastUserButton.addTarget(self, action: "lastUserButtonPress:", forControlEvents: .TouchUpInside)
        lastUserButton.setTitle("Find last user", forState: .Normal)

        let printEmailsButton = Button(frame: CGRectMake(1.5*Dimensions.MARGIN_LEFT+contentWidth/2.0, CGRectGetMaxY(usersLabel.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        printEmailsButton.addTarget(self, action: "printEmailsButtonPress:", forControlEvents: .TouchUpInside)
        printEmailsButton.setTitle("5 e-mail", forState: .Normal)
        
        let dataLabel = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(lastUserButton.frame)+Dimensions.MARGIN_LEFT, contentWidth, 14.0))
        dataLabel.text = "DATA"
        
        let lastRecordButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(dataLabel.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        lastRecordButton.addTarget(self, action: "lastRecordButtonPress:", forControlEvents: .TouchUpInside)
        lastRecordButton.setTitle("Find last record", forState: .Normal)
        
        let fiveTextsButton = Button(frame: CGRectMake(1.5*Dimensions.MARGIN_LEFT+contentWidth/2.0, CGRectGetMaxY(dataLabel.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        fiveTextsButton.addTarget(self, action: "fiveTextsButtonPress:", forControlEvents: .TouchUpInside)
        fiveTextsButton.setTitle("5 texts", forState: .Normal)
        
        let filesLabel = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(lastRecordButton.frame)+Dimensions.MARGIN_LEFT, contentWidth, 14.0))
        filesLabel.text = "FILES"
        
        let lastFileButon = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(filesLabel.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        lastFileButon.addTarget(self, action: "lastFileButtonPress:", forControlEvents: .TouchUpInside)
        lastFileButon.setTitle("Find last file", forState: .Normal)
        
        let largestFilesButton = Button(frame: CGRectMake(1.5*Dimensions.MARGIN_LEFT+contentWidth/2.0, CGRectGetMaxY(filesLabel.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        largestFilesButton.addTarget(self, action: "largestFilesButtonPress:", forControlEvents: .TouchUpInside)
        largestFilesButton.setTitle("5 largest files", forState: .Normal)
        
        let divider = self.divider(lastView:lastFileButon)
        view.layer.addSublayer(divider)
        
        view.addSubview(usersLabel)
        view.addSubview(dataLabel)
        view.addSubview(filesLabel)
        
        view.addSubview(lastUserButton)
        view.addSubview(printEmailsButton)
        view.addSubview(lastRecordButton)
        view.addSubview(fiveTextsButton)
        view.addSubview(lastFileButon)
        view.addSubview(largestFilesButton)
        
        let height : CGFloat = view.frame.size.height-CGRectGetMaxY(divider.frame)-2*Dimensions.MARGIN_LEFT
        textView = TextView(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(divider.frame)+Dimensions.MARGIN_LEFT, contentWidth, height))
        view.addSubview(textView)
        
        textView.text = "Review source code for more information about what's happening."
    }
    
    func lastUserButtonPress(button : UIButton)
    {
        HUD.showUIBlockingIndicator()
        
        SQuery(object: DemoUser()).orderBy("createdAt", direction: .Desc).top(1).find {
            (results : SResponseWrapper!) -> Void in
            
            if results.succeeded()
            {
                if results.results().first! is DemoUser
                {
                    let user = results.results().first! as! DemoUser
                    self.textView.text = user.email + (user.name != nil ? " (" + user.name + ")" : "")
                }
                else if results.results().first! is SynergykitUser
                {
                    let user = results.results().first! as! SynergykitUser
                    self.textView.text = user.email
                }
                else
                {
                    self.textView.text = "Unknown user type"
                }
                
            }
            else
            {
                self.textView.text = (((results.errors().first! as! NSError).userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
            }
            HUD.hideUIBlockingIndicator()
        }
    }
    
    func printEmailsButtonPress(button : UIButton)
    {
        HUD.showUIBlockingIndicator()

        SQuery(object: SynergykitUser()).orderBy("createdAt", direction: .Desc).top(5).find {
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            var output = ""
            for i in 0..<results.responses.count
            {
                let response = results.responses[i] as! SResponse
                if response.succeeded()
                {
                    output += (response.result as! SynergykitUser).email != nil ? (response.result as! SynergykitUser).email : "–"
                    output += "\n"
                }
                else
                {
                    output += ((response.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                }
            }
            self.textView.text = output
        }
    }
    
    func lastRecordButtonPress(button : UIButton)
    {
        HUD.showUIBlockingIndicator()
        SQuery(object: DemoObject(collection: DOME_OBJECTS_COLLECTION)).orderBy("createdAt", direction: .Desc).top(1).find {
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            if results.succeeded()
            {
                let object = results.results().first! as! DemoObject
                self.textView.text = object.text != nil ? object.text : "–"
            }
            else
            {
                self.textView.text = (((results.errors().first! as! NSError).userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
            }
        }
    }
    
    func fiveTextsButtonPress(button : UIButton)
    {
        HUD.showUIBlockingIndicator()
        
        SQuery(object: DemoObject(collection: DOME_OBJECTS_COLLECTION)).orderBy("createdAt", direction: .Desc).top(5).find {
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            var output = ""
            for i in 0..<results.responses.count
            {
                let response = results.responses[i] as! SResponse
                if response.succeeded()
                {
                    let object = response.result as! DemoObject
                    output += (object.text != nil ? object.text : "–") + "\n"
                }
                else
                {
                    output += ((response.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                }
            }
            self.textView.text = output
        }
    }
    
    func lastFileButtonPress(button : UIButton)
    {
        HUD.showUIBlockingIndicator()
        SQuery(object: SFile()).orderBy("createdAt", direction:.Desc).top(1).find {
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            if results.succeeded()
            {
                let file = results.results().first! as! SFile
                UIPasteboard.generalPasteboard().string = file.path
                self.textView.text = "Link copied to pasteboard (" + file.path + ")"
            }
            else
            {
                self.textView.text = (((results.errors().first! as! NSError).userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
            }
        }
    }
    
    func largestFilesButtonPress(button : UIButton)
    {
        HUD.showUIBlockingIndicator()
        SQuery(object: SFile()).orderBy("size", direction: .Desc).top(5).find {
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            var output = ""
            for i in 0..<results.responses.count
            {
                let response = results.responses[i] as! SResponse
                if response.succeeded()
                {
                    let file = response.result as! SFile
                    output += String(file.size.intValue/1024) + " kB\n"
                }
                else
                {
                    output += ((response.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                }
            }
            self.textView.text = output
        }
    }
    
}
