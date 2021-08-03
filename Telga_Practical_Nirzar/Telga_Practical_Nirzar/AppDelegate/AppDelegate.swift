//
//  AppDelegate.swift
//  SmartWorkx
//
//  Created by Nirzar Gandhi on 20/07/21.
//

var state : UIApplication.State!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Variable Declaration
    var window: UIWindow?
    var navhomeViewController : UINavigationController?
    let notificationDelegate = NotificationDelegate()
    
    //MARK: - AppDelegate Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if !isKeyPresentInUserDefaults(key: UserDefault.kIsKeyChain) {
            clearUserDefaultKeyChainData()
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        state = application.applicationState
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        //Push Notification
        setPushNotification(application)
        
        Utility().setRootLaunchVC()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        UIPasteboard.general.items = [[String: Any]()] 
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        state = application.applicationState
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        state = application.applicationState
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    //MARK: - Set Push Notification Method
    func setPushNotification(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { granted, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    return
                }
                
                if granted {
                    application.registerForRemoteNotifications()
                } else {
                }
            }
        })
    }
}

//MARK: - UNUserNotificationCenterDelegate Extension
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        
        print("Device Token : \(token)")
        
        KeychainWrapper.standard.set(token, forKey: UserDefault.kDeviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    //MARK: - Notification Methods
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert,.sound])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let userInfo = userInfo as NSDictionary
        print("didReceiveRemoteNotification userInfo : \(userInfo)")
        
        notificationNavigation(notificationData: userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    //MARK: - Notification Navigation Method
    func notificationNavigation(notificationData : NSDictionary) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let apns = notificationData.value(forKey: "aps") as! NSDictionary
        print("APNS : \(apns)")
    }
}
