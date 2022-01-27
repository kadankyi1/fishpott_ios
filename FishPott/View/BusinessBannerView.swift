//
//  BuySharesFormView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 1/27/22.
//

import SwiftUI
import URLImage // Import the package module

struct BusinessBannerView: View {
    // MARK: - PROPERTIES
    var businessID: String
    var businessName: String
    var businessLogo: String
    var businessCountry: String
    var businessType: String
    
    var body: some View {
            VStack(spacing: 10) {
                // INFO : HEADLINE
                let this_url = URL(string: businessLogo);
                URLImage(this_url!,
                         content: { image in
                             image
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 0)
                                .cornerRadius(100)
                         })
                Text(businessName)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                HStack(){
                    Text(businessCountry)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                    Text("|")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                    Text(businessType)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
            } //  VSTACK
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.black)
    }
}

struct BuySharesFormView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessBannerView(businessID: "ID5ID5", businessName: "Tee Shop", businessLogo: "startinfo2", businessCountry: "Ghana", businessType: "Restaurant")
    }
}
