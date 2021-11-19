//
//  IntroCardView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/19/21.
//

import SwiftUI

struct IntroCardView: View {
    // MARK: - PROPERTIES
    
    
    // MARK: BODY
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // INFO : IMAGE
                Image("startinfo1")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                // INFO : TITLE
                Text("Answer-To-Discover")
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
                // INFO : HEADLINE
                Text("Discover your trading nature. Train your FishPott to suggest stocks you will like to invest in.")
                    .foregroundColor(Color.white)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                // INFO : BUTTON-START
                
            } //  VSTACK
        } //  ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color("ColorBlackPrimary"), Color("ColorBlackPrimary")]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
    }
}

// MARK: - PREVIEW
struct IntroCardView_Previews: PreviewProvider {
    static var previews: some View {
        IntroCardView()
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
