//
//  PaymentBankTransferView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 8/16/22.
//

import SwiftUI

struct PaymentBankTransferView: View {
    // MARK: -- PROPERTIES
    
    var bankName: String
    var bankAddress: String
    var bankSwiftIban: String
    var bankBranch: String
    var accountName: String
    var accountNumber: String
    var referenceCode: String
    
    var body: some View {
        HStack {
            
            PriceSummaryListItemView(icon: "", name: "Bank: " + bankName).padding(.horizontal, 50)
            
            PriceSummaryListItemView(icon: "", name: "Bank Address: " + bankAddress).padding(.horizontal, 50)
            
            PriceSummaryListItemView(icon: "", name: "SWIFT/IBAN: " + bankSwiftIban).padding(.horizontal, 50)
            
            PriceSummaryListItemView(icon: "", name: "Branch: " + bankBranch).padding(.horizontal, 50)
            
            PriceSummaryListItemView(icon: "", name: "Account Name: " + accountName).padding(.horizontal, 50)
            
            PriceSummaryListItemView(icon: "", name: "Account No.: " + accountNumber).padding(.horizontal, 50)
            
            PriceSummaryListItemView(icon: "", name: "Ref. Code: " + referenceCode).padding(.horizontal, 50)
        }
    }
}

struct PaymentBankTransferView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentBankTransferView(bankName: "Access Bank", bankAddress: "91 Starlets Rd, Osu, Greater Accra", bankSwiftIban: "ACC3973", bankBranch: "Madina", accountName: "FishPot Company Limited", accountNumber: "97319373", referenceCode: "ACDDHO208284")
    }
}
