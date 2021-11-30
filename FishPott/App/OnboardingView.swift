//
//  OnboardingView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/19/21.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    var intro: [IntroModel] = introData
    @Binding var currentStage: String
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(intro[0...1]){ item in
                IntroCardView(intromodel: item, currentStage: $currentStage)
            } // LOOP
        } // TAB
        .tabViewStyle(PageTabViewStyle())
        //.padding(.vertical, 20)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(intro: introData, currentStage: .constant("SignupView"))
            .previewDevice("iPhone 11 Pro")
    }
}
