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
    
    @State var currentStage = getUserFirstOpenView("user_accesstoken")
    
    var body: some Scene {
        WindowGroup {
            
            if(self.currentStage == "OnboardingView"){
                //OnboardingView(currentStage: $currentStage)
                OnboardingView(intro: introData)
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
