//
//  AppDelegate.swift
//  DemoPushNotification
//
//  Created by Kai Pham on 4/27/18.
//  Copyright © 2018 Kai Pham. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureFirebase(on: application)
//        Messaging.messaging().apnsToken = nil
        return true
    }
    
    func registerNotification(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        Messaging.messaging().apnsToken = deviceToken // Disabled swizzling in plist.info
        let fcmToken = Messaging.messaging().fcmToken ?? ""
        
        print("=> FCM token: \(Messaging.messaging().fcmToken ?? "")")
        print("Device Token: \(token)")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("userNotificationCenter willPresent: \(notification.request.content.userInfo)")
        
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("userNotificationCenter didReceive: \(response.notification.request.content.userInfo)")
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("application didReceive: \(notification.userInfo)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("application didReceiveRemoteNotification: \(userInfo)")
    }
    
    
}

// MARK: Firebase messaging
extension AppDelegate: MessagingDelegate {
    func configureFirebase(on application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = true
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions,
                                                                    completionHandler: {_, _ in })
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        let googleServiceFile = "GoogleService-Info"
        
        let filePath = Bundle.main.path(forResource: googleServiceFile, ofType: "plist")!
        guard let options = FirebaseOptions(contentsOfFile: filePath) else {
            print("There are some problems with GoogleService-Info file")
            return
        }
        
        FirebaseApp.configure(options: options)
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("=> didRefreshRegistrationToken: \(fcmToken)")
    }
}


