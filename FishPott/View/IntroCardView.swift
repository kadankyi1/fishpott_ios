//
//  IntroCardView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/19/21.
//

import SwiftUI

struct IntroCardView: View {
    // MARK: - PROPERTIES
    var intromodel: IntroModel
    @State private var isAnimating: Bool = false
    @Binding var currentStage: String
    
    
    // MARK: BODY
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // INFO : IMAGE
                Image(intromodel.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                // INFO : TITLE
                Text(intromodel.title)
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
                // INFO : HEADLINE
                Text(intromodel.headline)
                    .foregroundColor(Color.white)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                // INFO : BUTTON-START
                StartButtonView(currentStage: $currentStage)
            } //  VSTACK
        } //  ZSTACK
        .onAppear{
            withAnimation(.easeOut(duration: 0.5)){
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: intromodel.gradidentColors), startPoint: .top, endPoint: .bottom))
        //.cornerRadius(20)
        //.padding(.horizontal, 15)
    }
}

// MARK: - PREVIEW
struct IntroCardView_Previews: PreviewProvider {
    static var previews: some View {
        IntroCardView(intromodel: introData[1], currentStage: .constant("SignupView"))
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
