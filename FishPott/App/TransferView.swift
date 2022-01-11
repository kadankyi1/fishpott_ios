//
//  TransferView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 1/11/22.
//

import SwiftUI

struct TransferView: View {
    
    // MARK: - PROPERTIES
    var stock_business_name: String
    var stock_ownership_id: String
    var quantity_available: Int
    
    var body: some View {
        Text("Transfers Here")
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView(stock_business_name: "Sample Stock", stock_ownership_id: "idididid", quantity_available: 100)
    }
}
