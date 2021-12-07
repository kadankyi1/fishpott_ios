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
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
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
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
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
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
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
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
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
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 10)
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
                            self.drillStage = 1
                            print("drillStage: \(self.drillStage)")
                        })
                    }
                        
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
        } //  VSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
    }
}

struct DrillQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DrillQuestionView(drillID: "testid", drillQuestion: "You are at the end of a cliff being chased by a lion", drillAnswer1: "I'm jumping", drillAnswer2: "I'm fighting", drillAnswer3: "What else can I do", drillAnswer4: "God help me", drillStage: .constant(0))
    }
}
