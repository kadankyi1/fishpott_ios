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
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(intro[0...1]){ item in
                IntroCardView(intromodel: item)
            } // LOOP
        } // TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

// MARK - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(intro: introData)
            .previewDevice("iPhone 11 Pro")
    }
}
