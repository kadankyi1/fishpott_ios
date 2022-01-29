//
//  ProfileView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct ProfileView: View {
    // MARK: -- PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profileDataFetchHttpAuth = ProfileDataFetchHttpAuth()
    
    // MARK: -- BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20){
                    // MARK: -- SECTION 1
                    
                    GroupBox(){
                        if profileDataFetchHttpAuth.authenticated == 4 {
                            ProfileRowView(icon: "house", name: profileDataFetchHttpAuth.pott_intelligence + " - Pott Intelligence")
                            Text("This is how well your FishPott knows you")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 12))
                            ProfileRowView(icon: "house", name: profileDataFetchHttpAuth.pott_networth + " - Net Worth")
                            ProfileRowView(icon: "house", name: profileDataFetchHttpAuth.pott_position + " - Pott Position")
                            Text("This is where you rank out of " + profileDataFetchHttpAuth.all_potts)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 12))
                        } else {
                            ProgressView()
                            .onAppear(perform: {
                                profileDataFetchHttpAuth.sendRequest(app_version: FishPottApp.app_version)
                            })
                        }
                    }
                    Divider().padding(.vertical, 2)
                    // MARK: -- SECTION 2
                    GroupBox(){
                        NavigationLink(destination: TransactionsView()){
                            ProfileRowView(icon: "house", name: "View Transactions")
                        }
                        Divider().padding(.vertical, 2)
                        NavigationLink(destination: AboutFishPottView()){
                            ProfileRowView(icon: "house", name: "Sellback Stocks")
                        }
                        Divider().padding(.vertical, 2)
                        NavigationLink(destination: AboutFishPottView()){
                            ProfileRowView(icon: "house", name: "Transfer Stocks")
                        }
                        Divider().padding(.vertical, 2)
                        //NavigationLink(destination:ContactUsView(contact_type: "Partnership", textfield_msg: "Type your testimony here", poster_image: "partnership")){
                            //SettingsRowView(icon: "donation", name: "Partnership")
                        //}
                        
                    }
                    Divider().padding(.vertical, 2)
                    GroupBox(){
                        
                        ProfileRowView(icon: "house", name: "Pottname | @" + getSavedString("user_pott_name"))
                        Divider().padding(.vertical, 2)
                        ProfileRowView(icon: "house", name: "Phone | " + getSavedString("user_phone"))
                        Divider().padding(.vertical, 2)
                        ProfileRowView(icon: "house", name: "Contact | info@fishPott.com")
                        Divider().padding(.vertical, 2)
                        ProfileRowView(icon: "house", name: "", content: nil, linkLabel: "Privacy Policy", linkDestination: "https://fishpott.com/pp.html")
                        
                    }
                }
            } // SCROLLVIEW
            .padding(.horizontal, 20)
        } // NAVIGATION
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}



class ProfileDataFetchHttpAuth: ObservableObject {

    @Published var authenticated = 3
    @Published var showLoginButton = true
    @Published var message = ""
    
    @Published var pott_networth: String = ""
    @Published var pott_intelligence: String = ""
    @Published var pott_position: String = ""
    @Published var all_potts: String = ""
    
    func sendRequest(app_version: String) {
    showLoginButton = false
        self.authenticated = 3
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/get-user-info") else { return }
        
    let body: [String: String] =
        [
            "user_phone_number": getSavedString("user_phone"),
            "user_pottname": getSavedString("user_pott_name"),
            "investor_id": getSavedString("user_id"),
            "app_type": "ios",
            "app_version_code": app_version,
            "user_language": "en"
        ]
    let finalBody = try! JSONSerialization.data(withJSONObject: body)
    print(body)
    print(finalBody)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = finalBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer " + getSavedString("access_token"), forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: request) { (data2, response, error) in
        print("starting 1")
        guard let data2 = data2 else { return }
        print("starting 2")
        print(data2)
        
        do {
            let json = try JSON(data: data2)
            print("json")
            print(json)
            if let status = json["status"].int {
              //Now you got your value
                //print(status)
                
                DispatchQueue.main.async {
                    if status == 1 {
                            self.authenticated = 4
                        print("b message: \(self.message)")
                        
                            if let pott_networth = json["data"]["pott_networth"].string {
                              //Now you got your value
                              self.pott_networth = pott_networth
                              print("pott_networth: \(pott_networth)")
                            }
                            
                            if let pott_intelligence = json["data"]["pott_intelligence"].string {
                                //Now you got your value
                                
                                self.pott_intelligence = String(pott_intelligence)
                                print("pott_intelligence: \(pott_intelligence)")
                              }
                        
                        if let pott_position = json["data"]["pott_position"].string {
                            //Now you got your value
                            self.pott_position = pott_position
                            print("pott_position: \(pott_position)")
                          }
                        
                        if let all_potts = json["data"]["all_potts"].string {
                            //Now you got your value
                            self.all_potts = all_potts
                            print("all_potts: \(all_potts)")
                          }
                    } else {
                        self.authenticated = 2
                        if let message = json["message"].string {
                            //Now you got your value
                              print(message)
                              self.message = message
                          }
                    }
                }
            } // END if let status = json["status"].in
        } catch  let error as NSError {
            print((error as NSError).localizedDescription)
            DispatchQueue.main.async {
                self.message = "Suggestion Retrieval Failed"
                self.authenticated = 2
            }
        }
        
    }.resume()
}
}
