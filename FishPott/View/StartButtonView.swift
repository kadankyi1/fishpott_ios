//
//  StartButtonView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/19/21.
//

import SwiftUI

struct StartButtonView: View {
    // MARK: - PROPERTIES
    @Binding var currentStage: String
    @AppStorage("isOnboardning") var isOnboarding: Bool?
    
    
    
    // MARK: - BODY
    
    var body: some View {
        Button(action: {
            //isOnboarding = false;
            self.currentStage = "LoginView"
        }) {
            HStack(spacing: 8) {
                Text("Start")
                
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )
                //.foregroundColor(Color.black)
        } //: BUTTON
        .accentColor(Color.white)
    }
}

// MARK: - PREVIEW
struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView(currentStage: .constant("LoginView"))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
