//
//  FinderView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct SellbackSharesView: View {
    // MARK: - PROPERTIES
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    var stock_business_name: String = ""
    var stock_ownership_id: String = ""
    var quantity_available: String = ""
    
    
    @State private var sell_quantity: String = ""
    @State private var account_name: String = ""
    @State private var bank_or_momo_number: String = ""
    @State private var bank_or_network_name: String = ""
    @State private var bank_routing_number: String = ""
    @State private var this_password: String = ""
    @ObservedObject var sellBackSharesHttpAuth = SellbackSharesHttpAuth()
    @State private var networking: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            if sellBackSharesHttpAuth.authenticated  == 0 ||  sellBackSharesHttpAuth.authenticated  == 2 {
                VStack(spacing: 10) {
                    
                Text(stock_business_name)
                        .foregroundColor(.black)
                    Text("Available : " + quantity_available)
                            .foregroundColor(.black)
                    
                    TextField("Sell Quantity", text: $sell_quantity).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    TextField("Name On Account", text: $account_name).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    TextField("Bank/Mobile Account Number", text: $bank_or_momo_number).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    TextField("Bank/Network Name", text: $bank_or_network_name).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    TextField("Routing Number(Banks Only)", text: $bank_routing_number).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    SecureField("Password", text: $this_password).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                        if sellBackSharesHttpAuth.authenticated  == 2 {
                            Text(sellBackSharesHttpAuth.message)
                            .font(.headline)
                            .foregroundColor(.red)
                        }
                        Button(action: {
                            print("FishPottApp.app_version: " + FishPottApp.app_version)
                            if sellBackSharesHttpAuth.authenticated  == 0 || sellBackSharesHttpAuth.authenticated  == 2 {
                                sellBackSharesHttpAuth.sendRequest(user_password: this_password, stockownership_id: stock_ownership_id, sell_quantity: sell_quantity, quantity_available: quantity_available, account_name: account_name, bank_or_momo_number: bank_or_momo_number, bank_or_network_name: bank_or_network_name, bank_routing_number: bank_routing_number, app_version: FishPottApp.app_version)
                                sellBackSharesHttpAuth.authenticated = 3
                                print("here 1")
                            }
                        }) {
                            HStack (spacing: 4) {
                                Text("Sell Back")
                                    .foregroundColor(Color("ColorWhiteAccent"))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 5)
                            .foregroundColor(Color("ColorWhiteAccent"))
                        } //: BUTTON
                        .accentColor(Color("ColorBlackPrimary"))
                        .background(Color("ColorBlackPrimary"))
                        .cornerRadius(5)
                        .padding(.bottom, 50)
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .background(Color.white)
            } else if sellBackSharesHttpAuth.authenticated  == 4 {
                VStack(spacing: 10) {
                    Image("roundlogo")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .top)
                            .padding(.vertical, 50)
                    Text(sellBackSharesHttpAuth.message)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 50)
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
        } else if sellBackSharesHttpAuth.authenticated  == 3 {
                    VStack(spacing: 10) {
                        Image("roundlogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 50)
                        Text("Processing sellback...")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        ProgressView()
                    } //  VSTACK
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
            } else {
                VStack(spacing: 10) {
                    Image("roundlogo")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .top)
                            .padding(.vertical, 50)
                    Text(sellBackSharesHttpAuth.message)
                    .font(.headline)
                    .foregroundColor(.red)
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
            }// MARK - if manager.authenticated
        } // SCROLLVIEW
    }
}

struct SellbackSharesView_Previews: PreviewProvider {
    static var previews: some View {
        SellbackSharesView()
    }
}



class SellbackSharesHttpAuth: ObservableObject {

    @Published var authenticated = 0
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var priceInCedis: String = ""
    @Published var priceInDollars: String = ""
    
    func sendRequest(user_password: String, stockownership_id: String, sell_quantity: String, quantity_available: String, account_name: String, bank_or_momo_number: String, bank_or_network_name: String, bank_routing_number: String, app_version: String) {
    showLoginButton = false
        self.authenticated = 3
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/sellback-stock") else { return }
        
    let body: [String: String] =
        [
            "user_phone_number": getSavedString("user_phone"),
            "user_pottname": getSavedString("user_pott_name"),
            "investor_id": getSavedString("user_id"),
            "app_type": "ios",
            "app_version_code": app_version,
            "user_language": "en",
            "user_password": user_password,
            "stockownership_id": stockownership_id,
            "transfer_quantity": sell_quantity,
            "bank_or_network_name": bank_or_network_name,
            "acc_name": account_name,
            "acc_number": bank_or_momo_number,
            "routing_number": bank_routing_number
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
                        
                        if let message = json["message"].string {
                            //Now you got your value
                            self.message = message
                            //if message == "success" {
                                self.authenticated = 4
                                print("b message: \(message)")
                                
                                if let priceInCedis = json["data"]["business_sys_id"].string {
                                  //Now you got your value
                                  self.priceInCedis = priceInCedis
                                  print("priceInCedis: \(priceInCedis)")
                                }
                                
                                if let priceInDollars = json["data"]["business_sys_id"].string {
                                    //Now you got your value
                                    self.priceInDollars = priceInDollars
                                    print("businessID: \(priceInDollars)")
                                  }
                                
                            /*
                             
                             } else {
                                self.authenticated = 0
                                print("err message: \(message)")
                            }
                             */
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
