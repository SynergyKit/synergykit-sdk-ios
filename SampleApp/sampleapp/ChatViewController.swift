//
//  ChatViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 23/02/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class ChatViewController: SuperViewController, UITextFieldDelegate, SObserverConnectionDelegate {

    let COLLECTION_NAME = "messages"
    var MY_USER_ID : String!
    let TESTING = false
    
    var textField : UITextField!
    var textView : UITextView!
    var messagesScrollView : ChatView!
    var typingRow : UIView!
    var sendButton : BrandButton!
    var typing : Label!
    var leftButton: Button!, rightButton : Button!
    var observers : [SObserver]!
    var typingObserver, userStateObserver : SObserver?
    var userName : String?
    
    var frameTypingShow : CGRect!
    var frameTypingHide : CGRect!
    var frameTextViewShow : CGRect!
    var frameTextViewHide : CGRect!
    
    var typingHidden : Bool!
    
    var alert : UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        
        MY_USER_ID = randomStringWithLength(10) as String
        
        observers = [SObserver]()
        
        setupContent()
        
        loginAndObserveTyping()
        
        SObserver.connectionDelegate(self)
        
        registerForKeyboardNotifications()
        
        alert = UIAlertController(title: "Synergykit", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let message = DemoMessage()
        message.name = self.userName != nil ? self.userName! : "Anonymous"
        message.text = "leaved"
        message.userId = self.MY_USER_ID
        
        self.userStateObserver?.speakWithObject(message)
        
        self.sendButton.enabled = true
        
        (SKSynergy.sharedInstance() as! SKSynergy).stopAllObservers()
    }

    func setupContent()
    {
        let marginLeft : CGFloat = 8
        let contentWidth : CGFloat = viewWidth-2*marginLeft
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        let typingRowHeight : CGFloat = 60.0
        
        typingRow = UIView(frame: CGRectMake(0.0, view.frame.size.height-typingRowHeight, viewWidth, typingRowHeight))
        view.addSubview(typingRow)
        
        typingRow.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        textField = TextField(frame: CGRectMake(marginLeft, (typingRowHeight-44.0)/2.0, round((contentWidth-marginLeft)*0.75), typingRowHeight-2*marginLeft))
        typingRow.addSubview(textField)
        
        textField.delegate = self
        textField.placeholder = "Write a message…"
        textField.addTarget(self, action: "textChanged:", forControlEvents: UIControlEvents.EditingChanged)
        textField.textAlignment = .Left
        
        let paddingView = UIView(frame: CGRectMake(0.0, 0.0, 10.0, typingRowHeight-2*marginLeft));
        textField.leftView = paddingView;
        textField.leftViewMode = .Always;
        
        sendButton = BrandButton(frame: CGRectMake(2*marginLeft+round((contentWidth-marginLeft)*0.75), (typingRowHeight-44.0)/2.0, round((contentWidth-marginLeft)*0.25), typingRowHeight-2*marginLeft))
        typingRow.addSubview(sendButton)
        
        sendButton.addTarget(self, action: "sendButtonPress:", forControlEvents: .TouchUpInside)
        sendButton.setTitle("Send", forState: .Normal)
        sendButton.enabled = false
        
        
        let height : CGFloat = view.frame.size.height-typingRowHeight
        messagesScrollView = ChatView(frame: CGRectMake(0.0, 0.0, viewWidth, height))
        view.insertSubview(messagesScrollView, belowSubview: typingRow)
        
        
        frameTypingShow = CGRectMake(0.0, 0.0, viewWidth, 18.0)
        frameTypingHide = CGRectMake(0.0, -18.0, viewWidth, 18.0)
        
        typing = Label(frame: frameTypingHide)
        typing.backgroundColor = UIColor(red: 0.573201143742, green: 0.716065967083, blue: 0.0, alpha: 1.0)
        typing.textColor = UIColor(white: 1.0, alpha: 1.0)
        typing.text = "X is typing…"
        
        view.addSubview(typing)
        
    }
    
    func textChanged(textField: UITextField!) {
        let message = DemoMessage()
        message.name = userName != nil ? userName! : "Anonymous"
        message.text = "is typing"
        message.userId = MY_USER_ID
        
        typingObserver?.speakWithObject(message)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return true
    }
    
    func loginAndObserveTyping()
    {
        
        self.typingHidden = true
        
        SObserver.connectionDelegate(self)
        
        // Fetch user name for typing
        if let name = NSUserDefaults.standardUserDefaults().objectForKey(StaticStrings.USER_NAME) as? String
        {
            userName = name
        }
        
        self.typingObserver = SObserver(speakName: "typing")
        self.typingObserver!.resultType = DemoMessage.self
        
        self.typingObserver!.startObservingWithObjectHandler({
            (result : AnyObject!) -> Void in
            
            if result != nil
            {
                let message = (result as! DemoMessage)
                if message.userId != self.MY_USER_ID && self.typingHidden == true
                {
                    self.typing.text = message.name + " " + message.text
                    self.typingHidden = false
                    
                    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.95, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                        () -> Void in
                        self.typing.frame = self.frameTypingShow
                        
                    }, completion: {
                        (finished : Bool) -> Void in
                        UIView.animateWithDuration(0.5, delay: 2.0, usingSpringWithDamping: 0.95, initialSpringVelocity: -20, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                            () -> Void in
                            self.typing.frame = self.frameTypingHide
                            
                        }, completion: {
                            (finished : Bool) -> Void in
                            self.typingHidden = true
                        })
                    })
                }
            }
        }, stateHandler: nil)
        
        
        self.userStateObserver = SObserver(speakName: "user_state")
        self.userStateObserver!.resultType = DemoMessage.self
        
        self.userStateObserver!.startObservingWithObjectHandler({
            (result : AnyObject!) -> Void in
            
            if result != nil
            {
                let message = (result as! DemoMessage)
                
                var bubble = ChatView.TextBubble()
                bubble.position =  .Center
                bubble.message = message.name + " " + message.text
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.messagesScrollView.addBubble(bubble)
                })
            }
            
        }, stateHandler: nil)
        
        
        let o = SObserver(object: DemoMessage(collection: self.COLLECTION_NAME), event: .POST)
        o.startObservingWithObjectHandler({
            (result : AnyObject!) -> Void in
            let message = result as! DemoMessage
            dispatch_async(dispatch_get_main_queue(),{
                var bubble = ChatView.TextBubble()
                bubble.author = message.name
                bubble.position = message.name == self.userName ? .Right : .Left
                bubble.message = message.text
                self.messagesScrollView.addBubble(bubble)
            })
        }, stateHandler: {
            (state : SObserverState, errors : [AnyObject]?) -> Void in
            
            if state == SObserverState.Subscribed
            {
                let message = DemoMessage()
                message.name = self.userName != nil ? self.userName! : "Anonymous"
                message.text = "joined"
                message.userId = self.MY_USER_ID
                
                self.userStateObserver?.speakWithObject(message)
                
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    self.sendButton.enabled = true
                })
            }
            else if state == SObserverState.Unsubscribed
            {
                let message = DemoMessage()
                message.name = self.userName != nil ? self.userName! : "Anonymous"
                message.text = "leaved"
                message.userId = self.MY_USER_ID
                
                self.userStateObserver?.speakWithObject(message)
                
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    self.sendButton.enabled = false
                })
            }
            else if state == SObserverState.Unauthorized
            {
                var bubble = ChatView.TextBubble()
                bubble.position = .Center
                bubble.message = "Unauthorized, sign in first!"
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    self.messagesScrollView.addBubble(bubble)
                })
            }
        })
    }
    
    func sendButtonPress(sender : UIButton)
    {
        if count(textField.text) > 0
        {
            // POST new data to collection
            var post = DemoMessage(collection: COLLECTION_NAME)
            post.text = textField.text
            post.name = userName != nil ? userName : "Anonymous"
            
            self.textField.text = ""
            
            post.save {
                (result : SResponse!) -> Void in
                
                if result.succeeded()
                {
                    self.textField.text = ""
                }
                else
                {
                    self.alert.message = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                    self.presentViewController(self.alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func observingConnectionDidChangeState(state: SObserverConnectionState)
    {
        dispatch_async(dispatch_get_main_queue(), {
            () -> Void in
            if state == SObserverConnectionState.Connected
            {
                var bubble = ChatView.TextBubble()
                bubble.position = .Center
                bubble.message = "Connected"
                self.messagesScrollView.addBubble(bubble)
            }
            else if state == SObserverConnectionState.Disconnected
            {
                var bubble = ChatView.TextBubble()
                bubble.position = .Center
                bubble.message = "Disconnected"
                self.messagesScrollView.addBubble(bubble)
                
                self.sendButton.enabled = false
            }
            else if state == SObserverConnectionState.Reconnected
            {
                var bubble = ChatView.TextBubble()
                bubble.position = .Center
                bubble.message = "Reconnected"
                self.messagesScrollView.addBubble(bubble)
            }
        })
    }
    
    func registerForKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification : NSNotification)
    {
        let info : [NSObject: AnyObject] = notification.userInfo!
        let kbSize : CGSize = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        
    }
    
    func keyboardWillShow(notification : NSNotification)
    {
        let info : [NSObject: AnyObject] = notification.userInfo!
        let kbSize : CGSize = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        
        var fRow = typingRow.frame
        fRow.origin.y = view.frame.size.height-kbSize.height-fRow.size.height
        
        var fMessages = messagesScrollView.frame
        fMessages.size.height = fRow.origin.y
        
        UIView.animateWithDuration(0.3, animations: {
            () -> Void in
            self.typingRow.frame = fRow
            self.messagesScrollView.repositionToSize(fMessages.size)  
        })
    }
    
    func keyboardWillBeHidden(notification : NSNotification)
    {
        let info : [NSObject: AnyObject] = notification.userInfo!
        let kbSize : CGSize = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        
        var fRow = typingRow.frame
        fRow.origin.y = view.frame.size.height-fRow.size.height
        
        var fMessages = messagesScrollView.frame
        fMessages.size.height = fRow.origin.y
        
        UIView.animateWithDuration(0.3, animations: {
            () -> Void in
            self.typingRow.frame = fRow
            self.messagesScrollView.repositionToSize(fMessages.size)
        })
    }

    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
}
