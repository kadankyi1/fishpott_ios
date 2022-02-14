//
//  MainView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/1/21.
//


import SwiftUI
import SwiftyJSON

struct MainView: View {
    @Binding var currentStage: String
    @ObservedObject var notificationManager : NotificationManager
    var thisDeviceToken : String?
    @ObservedObject var setDeviceTokenFetchHttpAuth = SetDeviceTokenFetchHttpAuth()
    
    init(currentStage: Binding<String>, notificationManager: NotificationManager, deviceToken: String) {
        self._currentStage = .constant("MainView")
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
        self.notificationManager = notificationManager
        self.thisDeviceToken = deviceToken
        print("3SNMDT thisDeviceToken: \(thisDeviceToken)")
        /*
         for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
         */
    }
    
    //var access_token: String = getSavedString("user_accesstoken");
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    @State var now = Date()
    
    let tabBarImageNames = ["suggestions", "finder", "investments", "profile", ]
    let tabBarMenuNames = ["Suggestions", "Finder", "Investments", "Profile"]
    
    var body: some View {
        
        /*
        var timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
            (_) in
            updateContent.update_content(user_accesstoken: getSavedString("user_accesstoken"));
        }
         */
        VStack(spacing: 0) {
            
        Text("FishPott ")
            .foregroundColor(Color(.black))
            .font(.custom("SweetSensationsPersonalUse", size: 30))
            .padding(.top, 5)
            
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        Button(action: {shouldShowModal.toggle()}, label: {
                            Text("Fullscreen cover")
                        })
                    
                })
                
                switch selectedIndex {
                case 0:
                    if (notificationManager.currentNotificationText == nil || notificationManager.currentNotificationText == "") {
                        SuggestionView()
                            .onAppear(perform: {
                                print("2SNMDT thisDeviceToken: \(thisDeviceToken)")
                                //if (notificationManager.currentNotificationText != nil && notificationManager.currentNotificationText != "") {
                                setDeviceTokenFetchHttpAuth.sendRequest(app_version: FishPottApp.app_version, device_token: thisDeviceToken ?? "")
                                //}
                            })

                    } else {
                        VStack{
                            VStack{
                            Text("NOTIFICATION")
                                .font(.system(size: 20))
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .shadow(radius: 8 )
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            VStack{
                                Text(self.notificationManager.currentNotificationText ?? "NO NOTIFICATION")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 50)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 500, idealHeight: 500, maxHeight: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            //.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            VStack{
                                Button(action: {
                                    self.notificationManager.currentNotificationText = ""
                                    //print("currentNotificationText: " + self.notificationManager.currentNotificationText ?? "")
                                }) {
                                    HStack (spacing: 8) {
                                        Text("Close")
                                            .foregroundColor(Color("ColorWhiteAccent"))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .foregroundColor(Color("ColorWhiteAccent"))
                                } //: BUTTON
                                .accentColor(Color("ColorBlackPrimary"))
                                .background(Color("ColorBlackPrimary"))
                                .cornerRadius(5)
                                .padding(.bottom, 50)
                                    
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .navigationTitle("My Mobile App")
                        .overlay(NavigationLink(destination: MyView(text: notificationManager.currentNotificationText ?? ""), isActive: notificationManager.navigationBindingActive, label: {
                            EmptyView()
                        }))
                        
                    }
                case 1:
                    FinderView()
                case 2:
                    InvestmentsView()
                case 3:
                    ProfileView()
                    
                default:
                    NavigationView {
                        Text("Remaining tabs")
                        
                    }
                }
                
            }
            
//            Spacer()
            
            Divider()
                .padding(.bottom, 8)
                .background(Color.white)
            
            HStack {
                ForEach(0..<4) { num in
                    Button(action: {
                        
                        /*
                        if num == 2 {
                            shouldShowModal.toggle()
                            return
                        }
                        */
                        
                        selectedIndex = num
                        
                    }, label: {
                        Spacer()
                        
                        VStack {
                                 Image(tabBarImageNames[num])
                                    .renderingMode(.template)
                                    .colorMultiply(.init(white: 0.8))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                                Text(tabBarMenuNames[num])
                                    .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                                    .font(.system(size: 12))
                            Spacer()
                        } // MARK: - VSTACK
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 55)
                    })
                    
                }
            } // MARK: - HSTACK
            
            .background(Color.white)
            
            
        }
        .background(Color.white)
    }
}

struct MyView: View {
    var text : String
    
    var body: some View {
        Text("Notification text is: " + text)
    }
}

/*
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(currentStage: .constant("MainView"), notificationManager: <#NotificationManager#>)
    }
}
*/


class SetDeviceTokenFetchHttpAuth: ObservableObject {

    @Published var authenticated = 3
    @Published var showLoginButton = true
    @Published var message = ""
    
    @Published var pott_networth: String = ""
    @Published var pott_intelligence: String = ""
    @Published var pott_position: String = ""
    @Published var all_potts: String = ""
    
    func sendRequest(app_version: String, device_token: String) {
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
            "user_language": "en",
            "fcm_token": device_token
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

