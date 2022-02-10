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

// PAYSTACK
@main
struct FishPottApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    //@AppStorage("isOnboardning") var isOnboarding: Bool = true
    static let app_version : String = "7"
    static let app_domain : String = "https://app.fishpott.com"
    
    @State var currentStage = getUserFirstOpenView("user_accesstoken");
    
    
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
                MainView(currentStage: $currentStage)
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


/*
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Paystack.setDefaultPublicKey("pk_live_d93022487706c680ab03c7a8d3a285898736527c")
        return true
    }
}
*/

//@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    
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
