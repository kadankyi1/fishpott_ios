//
//  ProfileView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct PersonaView: View {
    // MARK: -- PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var personaDataFetchHttpAuth = PersonaDataFetchHttpAuth()
    
    // MARK: -- BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20){
                    // MARK: -- SECTION 1
                    
                        if personaDataFetchHttpAuth.authenticated == 4 {
                            
                            Text(personaDataFetchHttpAuth.ai_info)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 12))
                            
                            GroupBox(){
                                ProfileRowView(icon: "ai", name: personaDataFetchHttpAuth.o + " - Openness")
                                HStack {
                                    Link("Likeness of new ideas and experiences", destination: URL(string: "https://en.wikipedia.org/wiki/Openness_to_experience")!)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                                }
                             }
                            Divider().padding(.vertical, 2)
                            GroupBox(){
                                ProfileRowView(icon: "ai", name: personaDataFetchHttpAuth.c + " - Conscientiousness")
                                HStack {
                                    Link("Being goal-directed, persistent, and organized", destination: URL(string: "https://en.wikipedia.org/wiki/Conscientiousness")!)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                                }
                             }
                            Divider().padding(.vertical, 2)
                            GroupBox(){
                                ProfileRowView(icon: "ai", name: personaDataFetchHttpAuth.e + " - Extraversion")
                                HStack {
                                    Link("Being energized by the outside world", destination: URL(string: "https://en.wikipedia.org/wiki/Extraversion_and_introversion")!)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                                }
                             }
                            Divider().padding(.vertical, 2)
                            GroupBox(){
                                ProfileRowView(icon: "ai", name: personaDataFetchHttpAuth.a + " - Agreeableness")
                                HStack {
                                    Link("Measure of cooperation with authority", destination: URL(string: "https://en.wikipedia.org/wiki/Agreeableness")!)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                                }
                             }
                            Divider().padding(.vertical, 2)
                            GroupBox(){
                                ProfileRowView(icon: "ai", name: personaDataFetchHttpAuth.n + " - Neuroticism")
                                HStack {
                                    Link("Sensitivity to stressy emotional triggers", destination: URL(string: "https://en.wikipedia.org/wiki/Neuroticism")!)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                                }
                             }
                        } else {
                          GroupBox(){
                            ProgressView()
                            .onAppear(perform: {
                                personaDataFetchHttpAuth.sendRequest(app_version: FishPottApp.app_version)
                            })
                          }
                       }
                }
            } // SCROLLVIEW
            .padding(.horizontal, 20)
        } // NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PersonaView_Previews: PreviewProvider {
    static var previews: some View {
        PersonaView()
    }
}



class PersonaDataFetchHttpAuth: ObservableObject {

    @Published var authenticated = 3
    @Published var showLoginButton = true
    @Published var message = ""
    
    @Published var ai_info: String = "This is your personality based on your drill answers. People who are in tune with wealth generation have a personality of at least 70% openness, 70% conscientiousness, 70% Extraversion, 70% Agreeableness, 70% Neuroticism."
    @Published var o: String = "10%"
    @Published var c: String = "35%"
    @Published var e: String = "90%"
    @Published var a: String = "43%"
    @Published var n: String = "5%"
    
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
                        
                            if let o = json["data"]["o"].string {
                              //Now you got your value
                              self.o = o
                              print("o: \(o)")
                            }
                            
                            if let c = json["data"]["c"].string {
                                //Now you got your value
                                
                                self.c = String(c)
                                print("c: \(c)")
                              }
                        
                        if let e = json["data"]["e"].string {
                            //Now you got your value
                            self.e = e
                            print("e: \(e)")
                          }
                        
                        if let a = json["data"]["a"].string {
                            //Now you got your value
                            self.a = a
                            print("a: \(a)")
                          }
                        
                        if let n = json["data"]["n"].string {
                            //Now you got your value
                            self.n = n
                            print("n: \(n)")
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
                self.message = "Persona Retrieval Failed"
                self.authenticated = 2
            }
        }
        
    }.resume()
}
}
