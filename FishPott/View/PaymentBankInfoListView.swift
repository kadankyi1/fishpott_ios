//
//  ProfileRowView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/14/21.
//

import SwiftUI

struct PaymentBankInfoListView: View {
    // MARK: -- PROPERTIES
    
    var icon: String
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
    
    
    // MARK: -- BODY
    var body: some View {
            Text(name)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 50)
            .foregroundColor(Color.gray)
            .font(.system(size: 13))
        
            Spacer()
        
    }
}


// MARK: -- PREVIEW
struct PaymentBankInfoListView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentBankInfoListView(icon: "house",name: "Prayer Requests Prayer Requests Prayer Requests Prayer Requests Prayer Requests Prayer Requests ")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
