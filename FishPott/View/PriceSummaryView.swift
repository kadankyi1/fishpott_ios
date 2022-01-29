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
            PriceSummaryListItemView(icon: "", name: "Item: " + businessName).padding(.horizontal, 50)
            PriceSummaryListItemView(icon: "", name: "Stocks Quantity: " + String(quantityToBuy)).padding(.horizontal, 50)
            PriceSummaryListItemView(icon: "", name: "Price Per Stock: " + pricePerItem).padding(.horizontal, 50)
            Divider().padding(.vertical, 2).padding(.horizontal, 50)
            PriceSummaryListItemView(icon: "", name: "Exchange Rate: " + dollarToCedisRate).padding(.horizontal, 50)
            PriceSummaryListItemView(icon: "", name: "Risk: " + riskStatement).padding(.horizontal, 50)
            PriceSummaryListItemView(icon: "", name: "Risk Fee: " + riskInsuranceFee).padding(.horizontal, 50)
            PriceSummaryListItemView(icon: "", name: "Processing Fee: " + processingFee).padding(.horizontal, 50)
            Divider().padding(.vertical, 2).padding(.horizontal, 50)
            PriceSummaryListItemView(icon: "", name: "Final Total Fee: " + overallTotalUsd).padding(.horizontal, 50)
        }
    }
}

struct PriceSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PriceSummaryView(businessName: "TT Shop", pricePerItem: "$10", quantityToBuy: 10, dollarToCedisRate: "$1 = Ghc10", riskStatement: "100% Risk Protection", riskInsuranceFee: "$10", processingFee: "$15", overallTotalUsd: "$1025")
    }
}
