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
                    Text("intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.titleintromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title intromodel.title")
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            ZStack {
                VStack(spacing: 2) {
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text("intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode ")
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .lineLimit(nil)
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text("intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode ")
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .lineLimit(nil)
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text("intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode ")
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .lineLimit(nil)
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text("intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode intromode ")
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                        
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

