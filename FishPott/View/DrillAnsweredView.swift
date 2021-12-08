//
//  DrillAnswer.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/5/21.
//

import SwiftUI

struct DrillAnsweredView: View {
    // MARK: - PROPERTIES
    var drillQuestion: String
    var drillAnswer1: String
    var drillAnswer2: String
    var drillAnswer3: String
    var drillAnswer4: String
    var drillAnswer1Count: String
    var drillAnswer2Count: String
    var drillAnswer3Count: String
    var drillAnswer4Count: String
    
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
            ZStack {
                VStack(spacing: 2) {
                    
                    GroupBox(label: Text("Answers Around The World").fontWeight(.heavy))
                    {}//: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .lineLimit(nil)
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(drillAnswer1Count + " People said...")
                            .font(.headline)
                            .fontWeight(.bold)
                            .onAppear(perform: {
                                    print("drillAnswer1Count: \(drillAnswer1Count)")
                            })
                        
                        Divider().padding(.vertical, 2)
                        Text(drillAnswer1)
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(drillAnswer2Count + " People said...")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Divider().padding(.vertical, 2)
                        Text(drillAnswer2)
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(drillAnswer3Count + " People said...")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Divider().padding(.vertical, 2)
                        Text(drillAnswer3)
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(drillAnswer4Count + " People said...")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Divider().padding(.vertical, 2)
                        Text(drillAnswer4)
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
                    .padding(.bottom, 80)
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

struct DrillAnsweredView_Previews: PreviewProvider {
    static var previews: some View {
        DrillAnsweredView(drillQuestion: "You are at the end of a cliff being chased by a lion", drillAnswer1: "I'm jumping", drillAnswer2: "I'm fighting", drillAnswer3: "What else can I do", drillAnswer4: "God help me", drillAnswer1Count: "1", drillAnswer2Count: "100K", drillAnswer3Count: "190", drillAnswer4Count: "230K" )
     
    }
}
