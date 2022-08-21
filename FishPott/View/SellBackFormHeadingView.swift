//
//  SellBackFormHeadingView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 8/20/22.
//

import SwiftUI

struct SellBackFormHeadingView: View {
    // MARK: -- PROPERTIES
    
    var stock_business_name: String
    var quantity_available: String
    var price_in_dollars: String
    
    var body: some View {
        Text(stock_business_name)
                .foregroundColor(.black)
            Text("Available : " + quantity_available)
                    .foregroundColor(.black)
            Text("Sellback Per Stock : " + price_in_dollars)
                    .foregroundColor(.black)
    }
}

struct SellBackFormHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        SellBackFormHeadingView(stock_business_name: "Randy Pharma", quantity_available: "10", price_in_dollars: "$1200")
    }
}
