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
    
    var body: some View {
        
            NavigationView {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 20){
                        // MARK: -- SECTION
                        GroupBox(){
                            NavigationLink(destination: TransferView(stock_business_name: stock_business_name, stock_ownership_id: stock_ownership_id, quantity_available: quantity_available)){
                                SharesToolboxMenuItemView(icon: "transfer", name: "Transfer Shares")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                        
                        Divider().padding(.vertical, 15)
                        
                        GroupBox(){
                            NavigationLink(destination: SellbackSharesView(stock_business_name: stock_business_name, stock_ownership_id: stock_ownership_id, quantity_available: quantity_available)){
                                SharesToolboxMenuItemView(icon: "transfer", name: "Sell Back Shares")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                        
                        Divider().padding(.vertical, 15)
                        
                        GroupBox(){
                            NavigationLink(destination: TransferView(stock_business_name: stock_business_name, stock_ownership_id: stock_ownership_id, quantity_available: quantity_available)){
                                SharesToolboxMenuItemView(icon: "favopt", name: "Favorites")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                    }
                } // SCROLLVIEW
            } // NAVIGATION
            .padding(.horizontal, 20)
        
    } // BODY
}

    // MARK: -- PROPERTIES
struct SharesToolBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SharesToolBoxView()
    }
}

