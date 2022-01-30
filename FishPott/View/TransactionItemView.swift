//
//  InvestmentItemView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/14/21.
//

import SwiftUI

struct TransactionItemView: View {
    // MARK: - PROPERTIES
    var transaction: TransactionModel
    
    // MARK: - BODY
    var body: some View {
        GroupBox(){
            VStack(spacing: 10) {
                
                HStack(){
                    VStack(spacing: 5) {
                        Text(transaction.type)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        Text(transaction.info_3)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                    }
                    
                    if transaction.info_1 == "Paid" || transaction.info_1 == "Completed" {
                        Text("  Completed  ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(2)
                    } else if transaction.info_1 == "Pending" {
                        Text("  " + transaction.info_1 + "  ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color.black)
                        .background(Color.yellow)
                        .cornerRadius(2)
                    }  else {
                        Text("  " + transaction.info_1 + "  ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(2)
                    }
                }
            
                HStack(){
                    VStack(spacing: 5) {
                        Text(transaction.info_4)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                        Text("Quantity")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    //Divider().padding(.vertical, 2)
                    Spacer()
                    VStack(spacing: 5) {
                        Text(transaction.info_2)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 15))
                        Text("Total")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                    }
                    
                    
                    Spacer()
                        Text(transaction.info_5)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .foregroundColor(Color.black)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.center)
                }
                
                VStack {
                        Text(transaction.info_6)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .foregroundColor(Color.black)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.center)
                        Text("Order ID")
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .foregroundColor(Color.black)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.center)
                } // VSTACK
            } //  VSTACK
            .clipped()
        }
        .padding(.horizontal, 5)
        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
    }
}

struct TransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemView(transaction: TransactionData[2])
    }
}
