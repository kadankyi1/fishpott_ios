//
//  InvestmentsView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct InvestmentsView: View {
    // MARK: - PROPERTIES
    @ObservedObject var investmentFetchHttpAuth = InvestmentFetchHttpAuth()
    
    var body: some View {
        NavigationView {
            if investmentFetchHttpAuth.authenticated == 4 {
                if investmentFetchHttpAuth.count_received_investments == 0 {
                    VStack(spacing: 10) {
                        Image("roundlogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 50)
                        Text("You have no investments")
                        .font(.headline)
                        .foregroundColor(Color.black)
                    }
                } else {
                    List {
                        Text("To transfer or sellback shares to another person, click on the investment in the list")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        
                                ForEach(investmentFetchHttpAuth.received_investments) { item in
                                    NavigationLink(destination: SharesToolBoxView(stock_business_name: item.business_name, stock_ownership_id: item.stock_id, quantity_available: item.quantity_of_stocks)){
                                    InvestmentItemView(investment: item)
                                }
                            }
                    }
                }
                
            } else if investmentFetchHttpAuth.authenticated == 3 {
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
                        investmentFetchHttpAuth.sendRequest(app_version: FishPottApp.app_version)
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
            //.navigationBarTitle("", displayMode: .inline)
        } // NAVIGATION
    }
}

struct InvestmentsView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentsView()
    }
}



class InvestmentFetchHttpAuth: ObservableObject {

    @Published var authenticated = 3
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var count_received_investments = 0
    @Published var received_investments: [InvestmentModel] = []
    
    func sendRequest(app_version: String) {
    showLoginButton = false
        self.authenticated = 3
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/get-my-investments") else { return }
        
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
                                if let stock_id = item["stock_id"].string {
                                    print(stock_id)
                                    if let business_id = item["business_id"].string {
                                        print(business_id)
                                    if let business_name = item["business_name"].string {
                                        print(business_name)
                                        if let cost_per_share_usd = item["cost_per_share_usd"].string {
                                            print(cost_per_share_usd)
                                            if let value_per_share_usd = item["value_per_share_usd"].string {
                                                    print(value_per_share_usd)
                                                    if let quantity_of_stocks = item["quantity_of_stocks"].int {
                                                        print(quantity_of_stocks)
                                                    if let value_phrase = item["value_phrase"].string {
                                                        print(value_phrase)
                                                        if let ai_info = item["ai_info"].string {
                                                            print(ai_info)
                                                            let number_of_stocks = String(quantity_of_stocks)
                                                            self.count_received_investments+=1
                                                            self.received_investments.append(InvestmentModel(
                                                                stock_id: stock_id, 
                                                                business_id: business_id,
                                                                business_name: business_name,
                                                                cost_per_share_usd: cost_per_share_usd,
                                                                value_per_share_usd: value_per_share_usd,
                                                                quantity_of_stocks: number_of_stocks,
                                                                value_phrase: value_phrase,
                                                                ai_info: ai_info
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
