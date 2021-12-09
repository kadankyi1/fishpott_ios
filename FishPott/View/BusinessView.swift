//
//  BusinessView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/8/21.
//

import SwiftUI

struct BusinessView: View {
    // MARK: - PROPERTIES
    var businessID: String
    var businessName: String
    var businessCountry: String
    var businessFindCode: String
    var businessType: String
    var businessLogo: String
    var businessDescription: String
    var businessAddress: String
    var businessStartDate: String
    var businessWebsite: String
    var businessPitchText: String
    var businessPitchVideo: String
    var businessLastYrRevenue: String
    var businessLastYrProfit: String
    var businessDebt: String
    var businessCashOnHand: String
    var businessNetWorth: String
    var businessPricePerStock: String
    var businessInvestmentAmtNeeded: String
    var businessInvestmentAmtReceived: String
    var businessMaxInvestorsNeeded: String
    var businessCurrentShareholders: String
    var businessFinancialReport: String
    var businessCeoName: String
    var businessCfoName: String
    
    var body: some View {
        VStack(spacing: 10) {
                VStack(spacing: 10) {
                    // INFO : HEADLINE
                    Image("layslogo")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .top)
                            .padding(.vertical, 0)
                            .cornerRadius(100)
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
                HStack(spacing: 2) {
                    Text("Be A Shareholder")
                        .foregroundColor(Color.black)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        Button(action: {}) {
                            HStack (spacing: 8) {
                                Text(" Buy Shares ")
                                    .foregroundColor(Color("ColorWhiteAccent"))
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            .foregroundColor(Color("ColorWhiteAccent"))
                        } //: BUTTON
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 30, idealHeight: 30, maxHeight: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 4)
                        .padding(.top, 4)
                        .padding(.horizontal, 10)
                        .lineLimit(nil)
                } //  VSTACK
                .padding(.top, 10)
                .background(Color.white)
                
                    VStack(spacing: 10) {
                        // INFO : HEADLINE
                        Image("layslogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 0)
                                .cornerRadius(100)
                        Text(businessName)
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                        HStack(){
                            Text(businessCountry)
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                            Text("|")
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                            Text(businessType)
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                        }
                    } //  VSTACK
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
            ZStack {
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
            
            
            
            
        } //  VSTACK
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 800, idealHeight: 800, maxHeight: 800, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(businessID: "testID", businessName: "Randy Pharmacy", businessCountry: "Ghana", businessFindCode: "TT-282201", businessType: "Pharmacy", businessLogo: "startinfo2", businessDescription: "This is a good business that has been around for over 15 years", businessAddress: "C/11, Taxi Rank, Madina - CD19991", businessStartDate: "Jan 12, 2005", businessWebsite: "https://github.com/kadankyi1?tab=overview", businessPitchText: "Be part of the sprout. You will love it", businessPitchVideo: "http://144.202.111.61/uploads/pitchvideos/CS201720810.mp4", businessLastYrRevenue: "$299,999", businessLastYrProfit: "$100,000", businessDebt: "0", businessCashOnHand: "$156000", businessNetWorth: "$300,500", businessPricePerStock: "$300", businessInvestmentAmtNeeded: "$100,000", businessInvestmentAmtReceived: "$35,000", businessMaxInvestorsNeeded: "20", businessCurrentShareholders: "10", businessFinancialReport: "http://144.202.111.61/uploads/financedata/CS201720810.pdf", businessCeoName: "Emelia Saint", businessCfoName: "Sanctum Heyst")
    }
}
