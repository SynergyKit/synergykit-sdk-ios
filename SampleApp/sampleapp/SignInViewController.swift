//
//  SignUpInViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 30/12/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class SignInViewController: SuperViewController, UITextFieldDelegate {
    
    let TESTING = false
    var scrollView : UIScrollView!
    let socialAuthenticator = LGSocialAuthenticator.sharedInstance() as! LGSocialAuthenticator
    var google, twitter, facebook, register : UIButton!
    var textView : UITextView!
    var userEmail, userPassword : UITextField!
    var emailTextField : UITextField?
    var newPlatformId : String?
    var alert : UIAlertController!
    
    // MARK:
    
// #############################################################################
    
    // MARK: Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Sign In"
        setupContent()
        
        registerForKeyboardNotifications()
        
        alert = UIAlertController(title: "Synergykit", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
    }
    
    // MARK:
    // MARK: GUI
    func setupContent()
    {
        scrollView = UIScrollView(frame: CGRectMake(0.0, 0.0, viewWidth, view.frame.size.height))
        view.addSubview(scrollView)
        
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        var label = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, contentWidth, 14.0))
        scrollView.addSubview(label)
        
        label.text = "VIA SOCIAL SERVICES"
        
        facebook = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(label.frame)+Dimensions.MARGIN_LEFT, contentWidth, 44.0))
        scrollView.addSubview(facebook)
        
        facebook.addTarget(self, action: "facebookButtonPress:", forControlEvents: .TouchUpInside)
        facebook.setTitle("Facebook", forState: .Normal)
        facebook.layer.borderColor = UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 164.0/255.0, alpha: 1.0).CGColor
        facebook.layer.borderWidth = 2.0
        
        twitter = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(facebook.frame)+Dimensions.MARGIN_LEFT, contentWidth, 44.0))
        scrollView.addSubview(twitter)
        
        twitter.addTarget(self, action: "twitterButtonPress:", forControlEvents: .TouchUpInside)
        twitter.setTitle("Twitter", forState: .Normal)
        twitter.layer.borderColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0).CGColor
        twitter.layer.borderWidth = 2.0
        
        google = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(twitter.frame)+Dimensions.MARGIN_LEFT, contentWidth, 44.0))
        scrollView.addSubview(google)
        
        google.addTarget(self, action: "googleButtonPress:", forControlEvents: .TouchUpInside)
        google.setTitle("Google+", forState: .Normal)
        google.layer.borderColor = UIColor(red: 215.0/255.0, green: 61.0/255.0, blue: 50.0/255.0, alpha: 1.0).CGColor
        google.layer.borderWidth = 2.0
        
        label = Label(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(google.frame)+Dimensions.MARGIN_LEFT, contentWidth, 14.0))
        scrollView.addSubview(label)
        
        label.text = "VIA E-MAIL"
    
        userEmail = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(label.frame)+Dimensions.MARGIN_LEFT/2.0, contentWidth, 44.0))
        scrollView.addSubview(userEmail!)
        
        userEmail.placeholder = "E-mail"
        userEmail.delegate = self
        userEmail.keyboardType = .EmailAddress
        userEmail.autocapitalizationType = .None
        userEmail.returnKeyType = UIReturnKeyType.Next
        
        userPassword = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(userEmail.frame)+Dimensions.MARGIN_LEFT/2.0, contentWidth, 44.0))
        scrollView.addSubview(userPassword!)
        
        userPassword.placeholder = "Password"
        userPassword.secureTextEntry = true
        userPassword.delegate = self
        
        register = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(userPassword.frame)+Dimensions.MARGIN_LEFT/2.0, contentWidth, 44.0))
        scrollView.addSubview(register)
        
        register.addTarget(self, action: "loginPress:", forControlEvents: .TouchUpInside)
        register.setTitle("Login user", forState: .Normal)
        
        scrollView.contentSize = CGSizeMake(viewWidth, CGRectGetMaxY(register.frame)+Dimensions.MARGIN_LEFT)
        
    }
    
    func registerForKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification : NSNotification)
    {
        let info : [NSObject: AnyObject] = notification.userInfo!
        let kbSize : CGSize = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillBeHidden(notification : NSNotification)
    {
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    // MARK:
    
// #############################################################################
    
    // MARK: Button Press handlers
    
    func loginPress(sender : UIButton)
    {
        view.endEditing(true)
        
        if userEmail.text.isEmpty || userPassword.text.isEmpty
        {
            alert.message = "Name, e-mail and password couldn't be empty."
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let u = DemoUser()
        u.email = userEmail.text
        u.password = userPassword.text
        
        userPassword.text = ""
        
        HUD.showUIBlockingIndicator()
   
        u.login {
            (result : SResponse!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            if result.succeeded()
            {
                self.userEmail.text = ""
                let newUser = result.result as! DemoUser
                
                self.alert.message = "Signed in as " + newUser.name
                self.presentViewController(self.alert, animated: true, completion: nil)
                
                NSUserDefaults.standardUserDefaults().setObject(newUser._id, forKey: StaticStrings.USER_ID)
                NSUserDefaults.standardUserDefaults().setObject(newUser.name, forKey: StaticStrings.USER_NAME)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            else
            {
                self.alert.message = (result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as? String
                self.presentViewController(self.alert, animated: true, completion: nil)
            }
        }
    }
    
    func facebookButtonPress(sender : UIButton)
    {
        /**
            Before uses of SKSocialAutheticator with Facebook login:
            1) Create new Facebook Application and make basic setup.
            2) Add line to Info.plist: FacebookAppID with appId of app which you just created.
            3) Add lines to Info.plist: URL types with structure as! URL types of this application
            4) Implement methods in AppDelegate like this app: applicationDidBecomeActive, application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?)
        **/
        
        facebookSignIn()
    }
    
    func twitterButtonPress(sender : UIButton)
    {
        /**
            Before uses of SKSocialAutheticator with Twitter OAuth:
            1) Create new Twitter Application and enable Sign in with Twitter.
        **/
        
        socialAuthenticator.twitterConsumerKey = "RKLonAjPNotCVJHznnw6Pfy5c"
        socialAuthenticator.twitterConsumerSecret = "EdbqjTzNhxhlYaJ6QL3JDVXWBTHDQw9ayZMmgeOaG9UT1ve7ji"
        
        twitterSignIn()
    }
    
    func googleButtonPress(sender : UIButton)
    {
        /**
            Before uses of SKSocialAutheticator with Google+ OAuth:
            1) You must create a Google Developers Console project and initialize the Google+ client. // https://developers.google.com/+/mobile/ios/getting-started
            2) Add lines to Info.plist: URL types with structure as! URL types of this application
            3) Implement method in AppDelegate like this app: application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?)
        **/
        
        socialAuthenticator.googleClientId = "940177421782-odl2q3aeth2t5m6nnef3v4ts61ounood.apps.googleusercontent.com"
        
        googleSignIn()
    }
    
    // MARK:
    
// #############################################################################
    
    // MARK: Sign In methods
    
    func facebookSignIn()
    {
        HUD.showUIBlockingIndicator()
        
        socialAuthenticator.readFacebookDataWithScope(["user_about_me", "email"], completion: {
            (userData : [NSObject : AnyObject]!, error : NSError!) -> Void in
            if error == nil && userData != nil
            {
                // Create new user
                var user = DemoUser()
                user.name = userData!["name"] as! String
                user.email = userData!["email"] as! String
                
                let facebookAuth = SAuthDataFacebook(id: userData!["id"] as! String, accessToken: userData["tokenString"] as! String)
                let authData = SAuthData(facebook:facebookAuth)
                user.authData = authData
                
                user.save {
                    (result : SResponse!) -> Void in
                    HUD.hideUIBlockingIndicator()
                    
                    if result.succeeded()
                    {
                        let newUser = result.result as! DemoUser
                        self.registerPlatform(newUser, completion: {
                            (result : SResponse!) -> Void in
                            if result.succeeded()
                            {
                                self.alert.message = "Signed in" + (newUser.name != nil ? " as " + newUser.name : "")
                                self.presentViewController(self.alert, animated: true, completion: nil)
                            }
                            else
                            {
                                self.alert.message = (result.error.userInfo![NSLocalizedDescriptionKey] as! String)
                                self.presentViewController(self.alert, animated: true, completion: nil)
                            }
                        })
                        
                        NSUserDefaults.standardUserDefaults().setObject(newUser._id, forKey: StaticStrings.USER_ID)
                        NSUserDefaults.standardUserDefaults().setObject(newUser.name, forKey: StaticStrings.USER_NAME)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    else
                    {
                        self.alert.message = (result.error.userInfo![NSLocalizedDescriptionKey] as! String)
                        self.presentViewController(self.alert, animated: true, completion: nil)
                        
                    }
                }
            }
            else
            {
                HUD.hideUIBlockingIndicator()
                self.alert.message = (error!.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as? String
                self.presentViewController(self.alert, animated: true, completion: nil)
            }
        })
    }
    
    func twitterSignIn()
    {
        HUD.showUIBlockingIndicator()
        
        socialAuthenticator.readTwitterDataWithCompletion {
            (userData : [NSObject : AnyObject]!, error : NSError!) -> Void in
            if error == nil && userData != nil
            {
                // Create new user
                var user = DemoUser()
                user.name = userData!["screenName"] as! String
                
                let twitterAuth = SAuthDataTwitter(id: userData!["_id"] as! String, screenName: userData!["screenName"] as! String, consumerKey: userData!["consumerKey"] as! String, consumerSecret: userData!["consumerSecret"] as! String, authToken: userData!["authToken"] as! String, authTokenSecret: userData!["authTokenSecret"] as! String)
                let authData = SAuthData(twitter: twitterAuth)
                user.authData = authData
                
                user.save {
                    (result : SResponse!) -> Void in
                    HUD.hideUIBlockingIndicator()
                    
                    if result.succeeded()
                    {
                        let newUser = result.result as! DemoUser
                        self.registerPlatform(newUser, completion: {
                            (result : SResponse!) -> Void in
                            if result.succeeded()
                            {
                                self.alert.message = "Signed in" + (newUser.name != nil ? " as " + newUser.name : "")
                                self.presentViewController(self.alert, animated: true, completion: nil)
                            }
                            else
                            {
                                self.alert.message = (result.error.userInfo![NSLocalizedDescriptionKey] as! String)
                                self.presentViewController(self.alert, animated: true, completion: nil)
                            }
                        })
                        
                        NSUserDefaults.standardUserDefaults().setObject(newUser._id, forKey: StaticStrings.USER_ID)
                        NSUserDefaults.standardUserDefaults().setObject(newUser.name, forKey: StaticStrings.USER_NAME)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    else
                    {
                        self.alert.message = (result.error.userInfo![NSLocalizedDescriptionKey] as! String)
                        self.presentViewController(self.alert, animated: true, completion: nil)
                        
                    }
                }
            }
            else
            {
                HUD.hideUIBlockingIndicator()
                self.alert.message = (error!.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as? String
                self.presentViewController(self.alert, animated: true, completion: nil)
            }
        }
    }
    
    func googleSignIn()
    {
        HUD.showUIBlockingIndicator()
        
        socialAuthenticator.readGoogleDataWithScope(["email", "profile"], completion: {
            (userData, error) -> Void in
            
            if error == nil && userData != nil
            {
                // Create new user
                var user = DemoUser()
                let name : String = (userData!["firstName"] as! String) + " " + (userData!["lastName"] as! String)
                user.name = name
                user.email = userData!["email"] as! String
                
                let googleAuth = SAuthDataGoogle(id: userData!["_id"] as! String, clientId: userData!["clientId"] as! String, accessToken: userData!["accessToken"] as! String, tokenType: userData!["tokenType"] as! String, refreshToken: userData!["refreshToken"] as! String, expirationDate:(userData!["expirationDate"] as! NSDate).timeIntervalSince1970)
                let authData = SAuthData(google:googleAuth)
                user.authData = authData
                
                user.save {
                    (result : SResponse!) -> Void in
                    HUD.hideUIBlockingIndicator()
                    
                    if result.succeeded()
                    {
                        let newUser = result.result as! DemoUser
                        self.registerPlatform(newUser, completion: {
                            (result : SResponse!) -> Void in
                            if result.succeeded()
                            {
                                self.alert.message = "Signed in" + (newUser.name != nil ? " as " + newUser.name : "")
                                self.presentViewController(self.alert, animated: true, completion: nil)
                            }
                            else
                            {
                                self.alert.message = (result.error.userInfo![NSLocalizedDescriptionKey] as! String)
                                self.presentViewController(self.alert, animated: true, completion: nil)
                            }
                        })
                        
                        NSUserDefaults.standardUserDefaults().setObject(newUser._id, forKey: StaticStrings.USER_ID)
                        NSUserDefaults.standardUserDefaults().setObject(newUser.name, forKey: StaticStrings.USER_NAME)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    else
                    {
                        self.alert.message = (result.error.userInfo![NSLocalizedDescriptionKey] as! String)
                        self.presentViewController(self.alert, animated: true, completion: nil)
                        
                    }
                }
            }
            else
            {
                HUD.hideUIBlockingIndicator()
                self.alert.message = (error!.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as? String
                self.presentViewController(self.alert, animated: true, completion: nil)
            }
        })
    }
    
    // MARK:
 
// #############################################################################
    
    // MARK: Helpers
    
    func registerPlatform(user: SynergykitUser, completion : (result : SResponse!) -> Void)
    {
        var apnsId = NSUserDefaults.standardUserDefaults().objectForKey(StaticStrings.APNS) as? String
        if apnsId == nil
        {
            completion(result: SKSynergy.responseWithDescription("apnsId is nil."))
            return
        }
        
        for platform in user.platforms
        {
            if platform.registrationId == apnsId
            {
                completion(result: SResponse(result: user, error: nil))
                return
            }
        }
        
        var platformUp = SPlatform()
        platformUp.registrationId = apnsId
        
        #if DEBUG
            platformUp.development = NSNumber(bool: true)
            #else
            platform.development = NSNumber(bool: false)
        #endif
        
        platformUp.save(completion)
    }
    
    func askEmail(completion : (email : String?) -> Void)
    {
//        if iOSVersion.IOS_GT_7_1
//        {
//            let dismissHandler = {
//                (sender : UIAlertAction!) -> Void in
//                self.dismissViewControllerAnimated(true, completion: nil)
//                HUD.hideUIBlockingIndicator()
//            }
//            
//            let okHandler = {
//                (sender : UIAlertAction!) -> Void in
//                if let textField = self.emailTextField
//                {
//                    if count(textField.text) > 0
//                    {
//                        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//                        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//                        if emailTest.evaluateWithObject(textField.text) == true
//                        {
//                            completion(email: textField.text)
//                        }
//                        else
//                        {
//                            completion(email: nil)
//                        }
//                    }
//                    else
//                    {
//                        completion(email: nil)
//                    }
//                }
//                else
//                {
//                    completion(email: nil)
//                }
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
//            
//            let alert = UIAlertController(title: "Additional Information", message: "Please fill in form.", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addTextFieldWithConfigurationHandler { textField in
//                textField.placeholder = "Your e-mail"
//                textField.keyboardType = UIKeyboardType.EmailAddress
//                self.emailTextField = textField
//            }
//            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: dismissHandler))
//            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: okHandler))
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
//        else
//        {
//            completion(email: "dummy@non-existing-mail.com")
//        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == userEmail)
        {
            userPassword.becomeFirstResponder()
        }
        else
        {
            view.endEditing(true)
        }
        return true
    }
}
