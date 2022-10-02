//
//  PriceSummaryView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 1/27/22.
//

import SwiftUI

struct PriceSummaryView: View {
    // MARK: - PROPERTIES
    var businessName: String
    var pricePerItem: String
    var quantityToBuy: Int
    var dollarToCedisRate: String
    var riskStatement: String
    var riskInsuranceFee: String
    var processingFee: String
    var overallTotalUsd: String
    
    var body: some View {
        GroupBox(){
            PaymentBankInfoListView(icon: "", name: "Item: " + businessName)
            PaymentBankInfoListView(icon: "", name: "Stocks Quantity: " + String(quantityToBuy))
            PaymentBankInfoListView(icon: "", name: "Price Per Stock: " + pricePerItem)
            Divider().padding(.vertical, 2).padding(.horizontal, 50)
            PaymentBankInfoListView(icon: "", name: "Exchange Rate: " + dollarToCedisRate)
            PaymentBankInfoListView(icon: "", name: "Risk: " + riskStatement)
            PaymentBankInfoListView(icon: "", name: "Risk Fee: " + riskInsuranceFee)
            PaymentBankInfoListView(icon: "", name: "Processing Fee: " + processingFee)
            Divider().padding(.vertical, 2).padding(.horizontal, 50)
            PaymentBankInfoListView(icon: "", name: "Final Total Fee: " + overallTotalUsd)
        }
    }
}

struct PriceSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PriceSummaryView(businessName: "TT Shop", pricePerItem: "$10", quantityToBuy: 10, dollarToCedisRate: "$1 = Ghc10", riskStatement: "100% Risk Protection", riskInsuranceFee: "$10", processingFee: "$15", overallTotalUsd: "$1025")
    }
}
