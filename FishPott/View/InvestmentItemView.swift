//
//  InvestmentItemView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/14/21.
//

import SwiftUI

struct InvestmentItemView: View {
    // MARK: - PROPERTIES
    var investment: InvestmentModel
    
    // MARK: - BODY
    var body: some View {
        GroupBox(){
            VStack(spacing: 10) {
                
                HStack(){
                    VStack(spacing: 5) {
                        Text(investment.business_name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        Text("Business Name")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                    }
                    
                    if investment.value_phrase == "Value Profit" {
                        Text("  " + investment.value_phrase + "  ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(2)
                    } else if investment.value_phrase == "Value Loss" {
                        Text("  " + investment.value_phrase + "  ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(2)
                    } else {
                        Text("  " + investment.value_phrase + "  ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color.white)
                        .background(Color.gray)
                        .cornerRadius(2)
                    }
                }
            
                HStack(){
                    VStack(spacing: 5) {
                        Text(investment.cost_per_share_usd)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                        Text("Cost Per Share")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    //Divider().padding(.vertical, 2)
                    Spacer()
                    VStack(spacing: 5) {
                        Text(investment.value_per_share_usd)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 15))
                        Text("Value Per Share")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    VStack(spacing: 5) {
                        Text(investment.quantity_of_stocks)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 15))
                        Text("Stocks Quantity")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                    }
                }
                
                Text(investment.ai_info)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .foregroundColor(Color.black)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
            } //  VSTACK
            .clipped()
        }
        .padding(.horizontal, 5)
        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
    }
}

struct InvestmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentItemView(investment: investmentData[1])
    }
}
