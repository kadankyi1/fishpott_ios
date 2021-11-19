//
//  OnboardingView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/19/21.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(0..<2){ item in
                IntroCardView()
            } // LOOP
        } // TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

// MARK - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
