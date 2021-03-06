//
//  DrillQuestionView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/6/21.
//

import SwiftUI

struct DrillQuestionView: View {
    // MARK: - PROPERTIES
    var drillID: String
    var drillQuestion: String
    var drillAnswer1: String
    var drillAnswer2: String
    var drillAnswer3: String
    var drillAnswer4: String
    @Binding var drillStage: Int
    @Binding var theDrillAnswer1Count: String
    @Binding var theDrillAnswer2Count: String
    @Binding var theDrillAnswer3Count: String
    @Binding var theDrillAnswer4Count: String
    @ObservedObject var answerDrillSuggestionHttpAuth = AnswerDrillSuggestionHttpAuth()
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                VStack(spacing: 20) {
                    // INFO : HEADLINE
                    Text(drillQuestion)
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 300, idealHeight: 300, maxHeight: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            ZStack {
                VStack(spacing: 2) {
                    
                    if answerDrillSuggestionHttpAuth.networking == 0 {
                        Button(action: {
                            answerDrillSuggestionHttpAuth.sendRequest(drill_id: drillID, drill_answer: "1", app_version: FishPottApp.app_version)
                        }) {
                            HStack (spacing: 8) {
                                Text(drillAnswer1)
                                    .foregroundColor(Color("ColorWhiteAccent"))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("ColorWhiteAccent"))
                        } //: BUTTON
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 10)
                        .padding(.top, 15)
                        .padding(.horizontal, 10)
                        .lineLimit(nil)
                        
                        Button(action: {
                            
                             answerDrillSuggestionHttpAuth.sendRequest(drill_id: drillID, drill_answer: "2", app_version: FishPottApp.app_version)
                        }) {
                            HStack (spacing: 8) {
                                Text(drillAnswer2)
                                    .foregroundColor(Color("ColorWhiteAccent"))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("ColorWhiteAccent"))
                        } //: BUTTON
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                        .lineLimit(nil)
                        
                        Button(action: {
                            
                             answerDrillSuggestionHttpAuth.sendRequest(drill_id: drillID, drill_answer: "3", app_version: FishPottApp.app_version)
                        }) {
                            HStack (spacing: 8) {
                                Text(drillAnswer3)
                                    .foregroundColor(Color("ColorWhiteAccent"))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("ColorWhiteAccent"))
                        } //: BUTTON
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                        .lineLimit(nil)
                        
                        Button(action: {
                            
                             answerDrillSuggestionHttpAuth.sendRequest(drill_id: drillID, drill_answer: "4", app_version: FishPottApp.app_version)
                        }) {
                            HStack (spacing: 8) {
                                Text(drillAnswer4)
                                    .foregroundColor(Color("ColorWhiteAccent"))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("ColorWhiteAccent"))
                        } //: BUTTON
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 80)
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                    } // if
                    
                    else if answerDrillSuggestionHttpAuth.networking == 1 {
                        ProgressView()
                    } else if answerDrillSuggestionHttpAuth.networking == 2 {
                        Text("...")
                        .font(.headline)
                        .foregroundColor(.green)
                        .onAppear(perform: {
                            self.theDrillAnswer1Count = answerDrillSuggestionHttpAuth.theDrillAnswer1Count
                            self.theDrillAnswer2Count = answerDrillSuggestionHttpAuth.theDrillAnswer2Count
                            self.theDrillAnswer3Count = answerDrillSuggestionHttpAuth.theDrillAnswer3Count
                            self.theDrillAnswer4Count = answerDrillSuggestionHttpAuth.theDrillAnswer4Count
                            self.drillStage = 1
                            print("self.theDrillAnswer4Count: \(self.theDrillAnswer4Count)")
                            print("drillStage: \(self.drillStage)")
                        })
                    }
                        
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
        } //  VSTACK
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 800, idealHeight: 800, maxHeight: 800, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.black)
    }
}

struct DrillQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DrillQuestionView(drillID: "testid", drillQuestion: "You are at the end of a cliff being chased by a lion", drillAnswer1: "I'm jumping", drillAnswer2: "I'm fighting", drillAnswer3: "What else can I do", drillAnswer4: "God help me", drillStage: .constant(0), theDrillAnswer1Count: .constant(""), theDrillAnswer2Count: .constant(""), theDrillAnswer3Count: .constant(""), theDrillAnswer4Count: .constant(""))
    }
}
