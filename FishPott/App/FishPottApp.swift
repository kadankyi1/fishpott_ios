//
//  FishPottApp.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/19/21.
//

import SwiftUI

@main
struct FishPottApp: App {
    //@AppStorage("isOnboardning") var isOnboarding: Bool = true
    static let app_version : String = "7"
    
    @State var currentStage = getUserFirstOpenView("user_accesstoken")
    
    var body: some Scene {
        WindowGroup {
            
            if(self.currentStage == "OnboardingView"){
                OnboardingView(currentStage: $currentStage)
                //OnboardingView(intro: introData)
            } else if(self.currentStage == "LoginView"){
                LoginView(currentStage: $currentStage)
            } else if(self.currentStage == "SignupView"){
                //SignupView(currentStage: $currentStage)
            } else {
                //MainView()
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
    //print("getSavedString: \(str)")
    if(str != "" && latest_audio_image != "" && latest_video1_image != "" && latest_video2_image != ""){
        if(user_firstname == "Guest" && user_lastname == "User"){
            str = "SignupView"
        } else {
            str = "MainView"
        }
    } else {
        str = "OnboardingView"
    }
    return str
    //let str = UserDefaults.standard.object(forKey: index) as? String
    //return str == nil ? "" : str!
}
