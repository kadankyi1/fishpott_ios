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
        VStack(){
            PaymentBankInfoListView(icon: "", name: "Bank: " + bankName)
            
            PaymentBankInfoListView(icon: "", name: "Bank Address: " + bankAddress)
            
            PaymentBankInfoListView(icon: "", name: "SWIFT/IBAN: " + bankSwiftIban)
            
            PaymentBankInfoListView(icon: "", name: "Branch: " + bankBranch)
            
            PaymentBankInfoListView(icon: "", name: "Account Name: " + accountName)
            
            PaymentBankInfoListView(icon: "", name: "Account No.: " + accountNumber)
            
            PaymentBankInfoListView(icon: "", name: "Ref. Code: " + referenceCode)
        }
    }
}

struct PaymentBankTransferView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentBankTransferView(bankName: "Access Bank", bankAddress: "91 Starlets Rd, Osu, Greater Accra, Ghana, West Africa", bankSwiftIban: "ACC3973", bankBranch: "Madina", accountName: "FishPot Company Limited", accountNumber: "97319373", referenceCode: "ACDDHO208284")
    }
}
