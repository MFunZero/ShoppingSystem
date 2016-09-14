//
//  AppDelegate.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/10.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import XCGLogger

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate,EMChatManagerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application
        
        let log = XCGLogger.defaultInstance()
        log.setup(.Debug, showLogIdentifier: true, showFunctionName: true, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: "/Users/fanzz/Documents/CodeForMe/ShoppingSystem/log/log", fileLogLevel: .Debug)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mma"
        dateFormatter.locale = NSLocale.currentLocale()
        log.dateFormatter = dateFormatter
        
        let  appkey = "allensuzee#shoppingsystem"
        let apnsCertName = "pushDevelopShopping"
        
        //  环信sdk
        let options = EMOptions(appkey: appkey)
        options.apnsCertName = apnsCertName
        
        EMClient.sharedClient().initializeSDKWithOptions(options)
        EMClient.sharedClient().chatManager.addDelegate(self)

        
        
        EaseSDKHelper.shareHelper().easemobApplication(application, didFinishLaunchingWithOptions:launchOptions,appkey:appkey,apnsCertName:apnsCertName,otherConfig:[kSDKConfigEnableConsoleLogger:true] )
        
        // 注册APNS
      
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
      
        return true
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        EMClient.sharedClient().bindDeviceToken(deviceToken)
    }
    
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("localNotification:\(notification.alertTitle)")
         let alert = UIAlertView(title: notification.alertTitle, message: "", delegate: self, cancelButtonTitle: "Cancel")

        alert.show()
        
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        let notifi = userInfo as NSDictionary
        let apsDic = notifi.objectForKey("aps") as! NSDictionary
        
        let alertDic = apsDic.objectForKey("alert") as! String
       
        print("userinfo:\(userInfo)")
        
        
    }

//    MARK:收到信息监听
    func didReceiveMessages(aMessages: [AnyObject]!) {
        
       let noti = UILocalNotification()
        noti.alertTitle = "ShoppingSystem"
        noti.fireDate = NSDate()
        noti.alertAction = "打开应用"
        noti.alertBody = "您有一条新消息"
        noti.soundName = UILocalNotificationDefaultSoundName
       UIApplication.sharedApplication().presentLocalNotificationNow(noti)
    }
    
    
    
    //    MARK:注册deviceToken失败
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("error -- RegisterForRemote  %@", error)
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let canHandleURL = Pingpp.handleOpenURL(url, withCompletion: nil)
        return canHandleURL
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        EMClient.sharedClient().applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        EMClient.sharedClient().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

