//
//  InvestmentsView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct TransactionsView: View {
    // MARK: - PROPERTIES
    @ObservedObject var transactionsFetchHttpAuth = TransactionsFetchHttpAuth()
    
    var body: some View {
        NavigationView {
            if transactionsFetchHttpAuth.authenticated == 4 {
                if transactionsFetchHttpAuth.count_received_items == 0 {
                    VStack(spacing: 10) {
                        Image("roundlogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 50)
                        Text("You have no transactions")
                        .font(.headline)
                        .foregroundColor(Color.black)
                    }
                } else {
                    List {
                        ForEach(transactionsFetchHttpAuth.received_items) { item in
                            TransactionItemView(transaction: item)
                        }
                    }
                }
                
            } else if transactionsFetchHttpAuth.authenticated == 3 {
                VStack(spacing: 10) {
                    Image("roundlogo")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .top)
                            .padding(.vertical, 50)
                    Text("Getting Your Investments...")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    ProgressView()
                    .onAppear(perform: {
                        transactionsFetchHttpAuth.sendRequest(app_version: FishPottApp.app_version)
                    })
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
            } else {
                VStack(spacing: 10) {
                    Image("roundlogo")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .top)
                            .padding(.vertical, 50)
                    Text("Failed to get investments. Try again later.")
                    .font(.headline)
                    .foregroundColor(Color.red)
                }
            }
            
        } // NAVIGATION
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}



class TransactionsFetchHttpAuth: ObservableObject {

    @Published var authenticated = 3
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var count_received_items = 0
    @Published var received_items: [TransactionModel] = []
    
    func sendRequest(app_version: String) {
    showLoginButton = false
        self.authenticated = 3
    guard let url = URL(string: "http://144.202.111.61/api/v1/user/get-my-transactions") else { return }
        
    let body: [String: String] =
        [
            "user_phone_number": getSavedString("user_phone"),
            "user_pottname": getSavedString("user_pott_name"),
            "investor_id": getSavedString("user_id"),
            "app_type": "ios",
            "app_version_code": app_version,
            "user_language": "en",
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
                print(status)
                DispatchQueue.main.async {
                    if status == 1 {
                        self.authenticated = 4
                        if let items = json["data"].array {
                            for item in items {
                                if let type = item["type"].string {
                                    print(type)
                                    if let info_1 = item["info_1"].string {
                                        print(info_1)
                                        if let info_2 = item["info_2"].string {
                                            print(info_2)
                                            if let info_3 = item["info_3"].string {
                                                    print(info_3)
                                                    if let info_4 = item["info_4"].string {
                                                        print(info_4)
                                                    if let info_5 = item["info_5"].string {
                                                        print(info_5)
                                                        if let info_6 = item["info_6"].string {
                                                            print(info_6)
                                                            self.count_received_items+=1
                                                            self.received_items.append(TransactionModel(
                                                                type: type,
                                                                info_1: info_1,
                                                                info_2: info_2,
                                                                info_3: info_3,
                                                                info_4: info_4,
                                                                info_5: info_5,
                                                                info_6: info_6
                                                            ))
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
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
