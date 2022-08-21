//
//  LibraryView.swift
//  GloryHub
//
//  Created by Dankyi Anno Kwaku on 27/02/2021.
//

import SwiftUI

struct SharesToolBoxView: View {
    // MARK: PROPERTIES
    var stock_business_name: String = ""
    var stock_ownership_id: String = ""
    var quantity_available: String = ""
    var buybackprice_usd: String = ""
    
    var body: some View {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 20){
                        // MARK: -- SECTION
                        GroupBox(){
                            NavigationLink(destination: TransferView(stock_business_name: stock_business_name, stock_ownership_id: stock_ownership_id, quantity_available: quantity_available)){
                                SharesToolboxMenuItemView(icon: "transfer2", name: "Transfer Shares")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                        
                        Divider().padding(.vertical, 15)
                        
                        GroupBox(){
                            NavigationLink(destination: SellbackSharesView(stock_business_name: stock_business_name, stock_ownership_id: stock_ownership_id, quantity_available: quantity_available, buyback_usd: buybackprice_usd)){
                                SharesToolboxMenuItemView(icon: "sellback", name: "Sell Back Shares")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                        
                    }
                } // SCROLLVIEW
            .padding(.horizontal, 20)
        
    } // BODY
}

    // MARK: -- PROPERTIES
struct SharesToolBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SharesToolBoxView()
    }
}

