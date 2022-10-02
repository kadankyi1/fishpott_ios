//
//  FishPottApp.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/19/21.
//

import SwiftUI
import Firebase
import UserNotifications
import Paystack

//new class to store notification text and to tell the NavigationView to go to a new page
class NotificationManager : ObservableObject {
    @Published var currentNotificationText : String?
    @Published var deviceToken : String?
    
    var navigationBindingActive : Binding<Bool> {
        .init { () -> Bool in
            self.currentNotificationText != nil
        } set: { (newValue) in
            if !newValue { self.currentNotificationText = nil }
        }
        
    }
}

enum Identifiers {
    static let viewAction = "VIEW_IDENTIFIER"
    static let readableCategory = "READABLE"
}

// PAYSTACK
@main
struct FishPottApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    //@AppStorage("isOnboardning") var isOnboarding: Bool = true
    static let app_version : String = "7"
    
    // LIVE OR TEST ENVIRONMENT
    static let app_domain : String = "https://app.fishpott.com"
    //static let app_domain : String = "https://test.fishpott.com"
    
    
    @State var currentStage = getUserFirstOpenView("user_accesstoken");
    @State var thisDeviceToken = getSavedString("devicetoken");
    @State var isFromNotif: Bool = false
    
    
    var body: some Scene {
        WindowGroup {
            
            if(self.currentStage == "OnboardingView"){
                OnboardingView(currentStage: $currentStage)
                //OnboardingView(intro: introData)
            } else if(self.currentStage == "LoginView"){
                LoginView(currentStage: $currentStage)
            } else if(self.currentStage == "SignupView"){
                SignupView(currentStage: $currentStage)
            } else {
                MainView(currentStage: $currentStage, notificationManager: appDelegate.notificationManager, deviceToken: thisDeviceToken)
                    .onAppear(perform: {
                        print("4SNMDT thisDeviceToken: \(thisDeviceToken)")
                    })
            }
            
        } // MARK: - WINDOW GROUP
    }
}


func getSavedString(_ index: String) -> String {
    var str = UserDefaults.standard.string(forKey: index) ?? ""
    //print("getSavedString: \(str)")
    return str
    //let str = UserDefaults.standard.object(forKey: index) as? String
    //return str == nil ? "" : str!
}

func getUserFirstOpenView(_ index: String) -> String {
    var str = UserDefaults.standard.string(forKey: index) ?? ""
    var user_phone = UserDefaults.standard.string(forKey: "user_phone") ?? ""
    var user_email = UserDefaults.standard.string(forKey: "user_email") ?? ""
    var user_id = UserDefaults.standard.string(forKey: "user_id") ?? ""
    var device_fcm_token = UserDefaults.standard.string(forKey: "devicetoken") ?? ""
    var access_token = UserDefaults.standard.string(forKey: "access_token") ?? ""
    var user_pott_name = UserDefaults.standard.string(forKey: "user_pott_name") ?? ""
    var user_full_name = UserDefaults.standard.string(forKey: "user_full_name") ?? ""
    var user_profile_picture = UserDefaults.standard.string(forKey: "user_profile_picture") ?? ""
    var user_country = UserDefaults.standard.integer(forKey: "user_verified_status") ?? 0
    var user_type = UserDefaults.standard.string(forKey: "user_type") ?? ""
    var user_gender = UserDefaults.standard.string(forKey: "user_gender") ?? ""
    var user_date_of_birth = UserDefaults.standard.string(forKey: "user_date_of_birth") ?? ""
    var user_currency = UserDefaults.standard.string(forKey: "user_currency") ?? ""
    var id_verification_is_on = UserDefaults.standard.bool(forKey: "id_verification_is_on") ?? false
    var media_allowed = UserDefaults.standard.integer(forKey: "media_allowed") ?? 0
    var user_min_allowed_version = UserDefaults.standard.integer(forKey: "user_min_allowed_version") ?? 0
    var mtn_momo_number = UserDefaults.standard.string(forKey: "mtn_momo_number") ?? ""
    var mtn_momo_acc_name = UserDefaults.standard.string(forKey: "mtn_momo_acc_name") ?? ""
    var vodafone_momo_number = UserDefaults.standard.string(forKey: "vodafone_momo_number") ?? ""
    var vodafone_momo_acc_name = UserDefaults.standard.string(forKey: "vodafone_momo_acc_name") ?? ""
    var airteltigo_momo_number = UserDefaults.standard.string(forKey: "airteltigo_momo_number") ?? ""
    var airteltigo_momo_acc_name = UserDefaults.standard.string(forKey: "airteltigo_momo_acc_name") ?? ""
    
    print("user_phone: \(user_phone)")
    print("user_id: \(user_id)")
    print("access_token: \(access_token)")
    print("user_pott_name: \(user_pott_name)")
    print("user_full_name: \(user_full_name)")
    if(user_phone != "" && user_id != "" && access_token != "" && user_pott_name != "" && user_full_name != ""){
            str = "MainView"
    } else {
        str = "OnboardingView"
    }
    return str
    //let str = UserDefaults.standard.object(forKey: index) as? String
    //return str == nil ? "" : str!
}


//@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    var notificationManager = NotificationManager() //here's where notificationManager is stored

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        Messaging.messaging().delegate = self

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
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

        print("userInfo 1")
        print(userInfo)
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            //completionHandler(.failed)
            return
        }
        print("new notification received")
        handleNotification(aps: aps)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

      let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        print("Device token: ", deviceToken) // This token can be used for testing notifications on FCM
        setDeviceToken(token: deviceToken["token"] ?? "")
        Messaging.messaging().subscribe(toTopic: "FISHPOT_TIPS") { error in
          print("Subscribed to FISHPOT_TIPS topic 1")
        }
        Messaging.messaging().subscribe(toTopic: "FISHPOT_IOS") { error in
          print("Subscribed to FISHPOT_IOS topic 1")
        }
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }

      print("userInfo 2")
      print(userInfo)
      guard let aps = userInfo["aps"] as? [String: AnyObject] else {
          //completionHandler(.failed)
          return
      }
      print("new notification received")
      handleNotification(aps: aps)

    // Change this to your preferred presentation option
    completionHandler([[.banner, .badge, .sound]])
  }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID from userNotificationCenter didReceive: \(messageID)")
    }

    print(userInfo)
      guard let aps = userInfo["aps"] as? [String: AnyObject] else {
          //completionHandler(.failed)
          return
      }
      print("new notification received")
      handleNotification(aps: aps)

    completionHandler()
  }
  @discardableResult func handleNotification(aps: [String:Any]) -> Bool {

        guard let alert = aps["alert"] as? String else { //get the "alert" field
            return false
        }
        guard let alert = aps["alert"] as? String else { //get the "alert" field
            return false
        }
        print("self.notificationManager.currentNotificationText")
        self.notificationManager.currentNotificationText = alert
        
        print(self.notificationManager.currentNotificationText)
        return true
  }
    
  @discardableResult func setDeviceToken(token: String) -> Bool {
        self.notificationManager.deviceToken = token
        
        saveTextInStorage("devicetoken", self.notificationManager.deviceToken ?? "")
        print("SNMDT self.notificationManager.deviceToken: \(self.notificationManager.deviceToken)")
        return true
  }
}


/************************************************************************************/
/************************************************************************************/
/************************************************************************************/
/************************************************************************************/


/*
//@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    //var isFromNotif: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        Messaging.messaging().delegate = self
        Paystack.setDefaultPublicKey("pk_live_d93022487706c680ab03c7a8d3a285898736527c")

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
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

      let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        print("Device token: ", deviceToken) // This token can be used for testing notifications on FCM
        
        Messaging.messaging().subscribe(toTopic: "FISHPOT_TIPS") { error in
          print("Subscribed to FISHPOT_TIPS topic 1")
        }
        Messaging.messaging().subscribe(toTopic: "FISHPOT_IOS") { error in
          print("Subscribed to FISHPOT_IOS topic 1")
        }
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }

    print(userInfo)
    self.isFromNotif = true;

    // Change this to your preferred presentation option
    completionHandler([[.banner, .badge, .sound]])
  }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID from userNotificationCenter didReceive: \(messageID)")
    }
      Messaging.messaging().subscribe(toTopic: "FISHPOT_TIPS") { error in
        print("Subscribed to FISHPOT_TIPS topic 2")
      }

    print(userInfo)

    completionHandler()
  }
}
*/

/************************************************************************************/
/************************************************************************************/
/************************************************************************************/
/************************************************************************************/
/*
class AppDelegate: NSObject, UIApplicationDelegate {
    var notificationManager = NotificationManager() //here's where notificationManager is stored
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self// set the delegate
        registerForPushNotifications()
        return true
    }
    func application(  // registers for notifications and gets token
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        setDeviceToken(token: token)
        print("device token : \(token)")
    }//handles sucessful register for notifications
    
    func application( //handles unsucessful register for notifications
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register: \(error)")
    }//handles unsucessful register for notifications
    
    func application(   //handles notifications when app in foreground
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler:
            @escaping (UIBackgroundFetchResult) -> Void
    ) {
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        print("new notification received")
        handleNotification(aps: aps)
        completionHandler(.noData)
    }//handles notifications when app in foreground
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                print("permission granted: \(granted)")
                guard granted else { return }
                let viewAction = UNNotificationAction(
                    identifier: Identifiers.viewAction,
                    title: "Mark as read",
                    options: [.foreground])
                
                let readableNotification = UNNotificationCategory(
                    identifier: Identifiers.readableCategory,
                    actions: [viewAction],
                    intentIdentifiers: [],
                    options: [])
                UNUserNotificationCenter.current().setNotificationCategories([readableNotification])
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            print("notification settings: \(settings)")
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        if let aps = userInfo["aps"] as? [String: AnyObject] {
            handleNotification(aps: aps)
        }
    }
}

extension AppDelegate {
    @discardableResult func handleNotification(aps: [String:Any]) -> Bool {

        guard let alert = aps["alert"] as? String else { //get the "alert" field
            return false
        }
        guard let alert = aps["alert"] as? String else { //get the "alert" field
            return false
        }
        self.notificationManager.currentNotificationText = alert
        return true
    }
}

extension AppDelegate {
    @discardableResult func setDeviceToken(token: String) -> Bool {
        self.notificationManager.deviceToken = token
        
        saveTextInStorage("devicetoken", self.notificationManager.deviceToken ?? "")
        print("SNMDT self.notificationManager.deviceToken: \(self.notificationManager.deviceToken)")
        return true
    }
}
 */
