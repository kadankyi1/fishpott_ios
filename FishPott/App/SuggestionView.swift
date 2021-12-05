//
//  SuggestionView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI

struct SuggestionView: View {
    // MARK: - PROPERTIES
    @State private var shouldRefresh = false
    
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                VStack(spacing: 20) {
                    // INFO : HEADLINE
                    Text(" intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.titleintromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title")
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            ZStack {
                VStack(spacing: 20) {
                    Button(action: {
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_phone_number: self.username, password: self.password, app_version: FishPottApp.app_version)
                        }
                        */
                        
                    }) {
                        HStack (spacing: 8) {
                            Text("intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode ").lineLimit(nil)
                                .foregroundColor(Color.black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color.black)
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .center)
                    .accentColor(Color.black)
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding(.bottom, 50)
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
        } //  VSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionView()
    }
}

