//
//  ProfileRowView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/14/21.
//

import SwiftUI

struct ProfileRowView: View {
    // MARK: -- PROPERTIES
    
    var icon: String
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
    
    
    // MARK: -- BODY
    var body: some View {
        HStack {
            Image(icon)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                .cornerRadius(8)
            Spacer()
            Text(name)
                .foregroundColor(Color.gray)
            
            if(content != nil){
                
            } else if(linkLabel != nil && linkDestination != nil){
                Link(linkLabel!, destination: URL(string: linkDestination!)!)
                    .foregroundColor(Color.gray)
                Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
            } else {
                EmptyView()
            }
        }
    }
}


// MARK: -- PREVIEW
struct ProfileRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRowView(icon: "newwitness",name: "Prayer Requests")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
