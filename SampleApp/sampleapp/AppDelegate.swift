//
//  AppDelegate.swift
//  sampleapp
//
//  Created by Jan Čislinský on 29/12/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var notificationController : NotificationsViewController?
    
// #############################################################################
// MARK: Application Delegate
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        setupContent()
        
        // Connect SynergyKIT with application.
        Synergykit.setTenant("synergykit-sample-app", key: "9cfe5f27-f54b-40b7-a8bb-e12a89eb9275")
//        Synergykit.setTenant("synergykit", key: "fc78cd74-51db-411f-b749-6f8a770f7034")
        Synergykit.enableDebugging(true)
        
        // Enable Remote Notification in Target setting: Capabilities › Background Modes › Remote notifications
        // Implement method application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)

        // Register for remote notification
        if iOSVersion.IOS_GT_7_1
        {
            let userNotificationSetting = UIUserNotificationSettings(forTypes: (.Badge | .Sound | .Alert), categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(userNotificationSetting)
            
            UIApplication.sharedApplication().registerForRemoteNotifications()
        }
        else
        {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes((UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert))
        }
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        HUD.hideUIBlockingIndicator()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        NSUserDefaults.standardUserDefaults().removeObjectForKey(StaticStrings.USER_ID)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(StaticStrings.USER_NAME)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool
    {
        if url.absoluteString!.rangeOfString("fb909004705799278") != nil
        {
            FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        }
        return GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)

    }
    
// #############################################################################
// MARK: Remote Notification Registration
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    {
        var userId = NSUserDefaults.standardUserDefaults().valueForKey(StaticStrings.APNS) as? String
        
        if userId == nil
        {
            // User is not registered yet.
            let newUserId = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "")
            NSUserDefaults.standardUserDefaults().setObject(newUserId, forKey: StaticStrings.APNS)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            userId = newUserId
        }
        
        println("APNS user id: \(userId!)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError)
    {
            println(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void)
    {
        println("Did Received Remote Notification")
        notificationController?.receivedNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    
// #############################################################################
// MARK: GUI
    
    func setupContent()
    {
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        let master = MainViewController()
        let masterNav = UINavigationController(rootViewController:master)
        window?.rootViewController = masterNav
        
        UINavigationBar.appearance().barTintColor = Colors.brand
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
}

// #############################################################################
// MARK:

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static var SCREEN_WIDTH : CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    static var SCREEN_HEIGHT : CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}

struct iOSVersion
{
    static let IOS_LE_6_1 = floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1
    static let IOS_LE_7_1 = floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1
    static let IOS_GT_7_1 = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1
}

struct Colors
{
    static let brand : UIColor = UIColor(red: 19/255.0, green: 100.0/255.0, blue: 214/255.0, alpha: 1.0)
}

struct StaticStrings
{
    static let APNS : String = "apnsId"
    static let USER_ID : String = "CurrentUserId"
    static let USER_NAME : String = "CurrentUserName"
}

struct Dimensions
{
    static let MARGIN_LEFT : CGFloat = 16.0
}