//
//  FinderView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct TransferView: View {
    // MARK: - PROPERTIES
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    
    var stock_business_name: String = ""
    var stock_ownership_id: String = ""
    var quantity_available: String = ""
    
    
    @State private var receiver_pottname: String = ""
    @State private var transfer_quantity: String = ""
    @State private var this_password: String = ""
    @ObservedObject var transferSharesHttpAuth = TransferSharesHttpAuth()
    @State private var networking: Bool = false
    
    @State private var transaction_id: String = ""
    @State private var payment_date: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            if transferSharesHttpAuth.authenticated  == 0{
                VStack(spacing: 10) {
                    
                Text(stock_business_name)
                        .foregroundColor(.black)
                    
                    TextField("Transfer Amount", text: $transfer_quantity).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    TextField("Receiver Pottname", text: $receiver_pottname).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    TextField("Your Password", text: $this_password).textFieldStyle(RoundedBorderTextFieldStyle.init())
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                        if transferSharesHttpAuth.authenticated  == 4 {
                            Text(transferSharesHttpAuth.message)
                            .font(.headline)
                            .foregroundColor(.red)
                        }
                        Button(action: {
                            print("FishPottApp.app_version: " + FishPottApp.app_version)
                            if networking == false {
                                networking = true;
                                transferSharesHttpAuth.sendRequest(user_password: this_password, stockownership_id: stock_ownership_id, transfer_quantity: transfer_quantity, quantity_available: quantity_available, receiver_pottname: receiver_pottname, app_version: FishPottApp.app_version);
                                transferSharesHttpAuth.authenticated = 3
                                print("here 1")
                            }
                        }) {
                            HStack (spacing: 4) {
                                Text("Transfer")
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
            } else if transferSharesHttpAuth.authenticated  == 4 {
                
            VStack {
                
                PriceSummaryListItemView(icon: "", name: "Number: " + transferSharesHttpAuth.mobileMoneyNumber).padding(.horizontal, 50)
                
                PriceSummaryListItemView(icon: "", name: "Name: " + transferSharesHttpAuth.mobileMoneyName).padding(.horizontal, 50)
                
                
                Text("Send full payment to the mobile money number above and type in the transaction ID you receive from the network operator after you send")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 50)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 12))
                
                TextField("Transaction ID", text: $transaction_id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)
                    .padding([.top,.leading,.trailing])
                
                TextField("Payment Date", text: $payment_date)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)
                    .padding([.top,.leading,.trailing])
                
                if transferSharesHttpAuth.processingPayment == 0 || transferSharesHttpAuth.processingPayment == 4 || transferSharesHttpAuth.processingPayment == 2 {
                    
                    if transferSharesHttpAuth.processingPayment == 4 {
                        Text("Transaction recorded successfully and under review. Please write this transaction ID for reference: " + transferSharesHttpAuth.transactionOrderID)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal, 50)
                            .foregroundColor(Color.green)
                            .font(.system(size: 12))
                    } else if transferSharesHttpAuth.processingPayment == 2 {
                        Text(transferSharesHttpAuth.message)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal, 50)
                            .foregroundColor(Color.red)
                            .font(.system(size: 12))
                    }
                    Button(action: {
                        
                        if(transferSharesHttpAuth.processingPayment == 0 || transferSharesHttpAuth.processingPayment == 2){
                            transferSharesHttpAuth.sendPaymentRequest(stockpurchase_id: transferSharesHttpAuth.orderID, momo_transaction_with_date: "Momo ID: " + transaction_id + " - Date: " + payment_date, app_version: FishPottApp.app_version);
                            //getFinalPriceHttpAuth.authenticated = 3
                        }
                        
                    }) {
                        HStack (spacing: 4) {
                            Text(" Send ")
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 5)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 120)
                } else if transferSharesHttpAuth.processingPayment == 3 {
                        ProgressView()
                } else if transferSharesHttpAuth.processingPayment == 0 {
                    
                }
                
                
            } //  VSTACK
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
            } else if transferSharesHttpAuth.authenticated  == 3 {
                    VStack(spacing: 10) {
                        Image("roundlogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 50)
                        Text("Processing transfer...")
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
                    Text(transferSharesHttpAuth.message)
                    .font(.headline)
                    .foregroundColor(.red)
                    .onTapGesture {
                       if networking == false {
                           networking = true
                           transferSharesHttpAuth.sendRequest(user_password: this_password, stockownership_id: stock_ownership_id, transfer_quantity: transfer_quantity, quantity_available: quantity_available, receiver_pottname: receiver_pottname, app_version: FishPottApp.app_version);
                           transferSharesHttpAuth.authenticated = 3
                           print("here new 1")
                       }
                    }
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
            }// MARK - if manager.authenticated
        } // SCROLLVIEW
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}



class TransferSharesHttpAuth: ObservableObject {

    @Published var authenticated = 0
    @Published var processingPayment = 0
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var priceInCedis: String = ""
    @Published var priceInDollars: String = ""
    @Published var orderID: String = ""
    @Published var paymentGatewayCurrency: String = ""
    @Published var paymentGatewayAmt: Int = 0
    @Published var mobileMoneyNumber: String = ""
    @Published var mobileMoneyName: String = ""
    @Published var transactionOrderID: String = ""
    
    func sendRequest(user_password: String, stockownership_id: String, transfer_quantity: String, quantity_available: String, receiver_pottname: String, app_version: String) {
    showLoginButton = false
        self.authenticated = 3
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/send-stock-transfer") else { return }
        
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
            "transfer_quantity": transfer_quantity,
            "receiver_pottname": receiver_pottname
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
                            if message == "success" {
                                self.authenticated = 4
                                print("b message: \(message)")
                                
                                if let orderID = json["data"]["transanction_id"].string {
                                  //Now you got your value
                                  self.orderID = orderID
                                  print("orderID: \(orderID)")
                                }
                                
                                if let priceInCedis = json["data"]["overall_total_local_currency"].string {
                                  //Now you got your value
                                  self.priceInCedis = priceInCedis
                                  print("priceInCedis: \(priceInCedis)")
                                }
                                
                                if let priceInDollars = json["data"]["overall_total_usd"].string {
                                    //Now you got your value
                                    self.priceInDollars = priceInDollars
                                    print("businessID: \(priceInDollars)")
                                  }
                                
                                
                                if let paymentGatewayCurrency = json["data"]["payment_gateway_currency"].string {
                                    //Now you got your value
                                    self.paymentGatewayCurrency = paymentGatewayCurrency
                                    print("paymentGatewayCurrency: \(paymentGatewayCurrency)")
                                }
                                
                                if let paymentGatewayAmt = json["data"]["payment_gateway_amount_in_pesewas_or_cents_intval"].int {
                                    //Now you got your value
                                    self.paymentGatewayAmt = paymentGatewayAmt
                                    print("paymentGatewayAmt: \(paymentGatewayAmt)")
                                }
                                
                                if let paymentGatewayCurrency = json["data"]["payment_gateway_currency"].string {
                                    //Now you got your value
                                    self.paymentGatewayCurrency = paymentGatewayCurrency
                                    print("paymentGatewayCurrency: \(paymentGatewayCurrency)")
                                }
                                
                                if let mobileMoneyNumber = json["data"]["mobile_money_number"].string {
                                    //Now you got your value
                                    self.mobileMoneyNumber = mobileMoneyNumber
                                    print("mobileMoneyNumber: \(mobileMoneyNumber)")
                                }
                                
                                if let mobileMoneyName = json["data"]["mobile_money_name"].string {
                                    //Now you got your value
                                    self.mobileMoneyName = mobileMoneyName
                                    print("mobileMoneyName: \(mobileMoneyName)")
                                }
                                
                            } else {
                                self.authenticated = 0
                                print("err message: \(message)")
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
    
    
    func sendPaymentRequest(stockpurchase_id: String, momo_transaction_with_date: String, app_version: String) {
    showLoginButton = false
        self.processingPayment = 3
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/update-order-payment-status") else { return }
        
    let body: [String: String] =
        [
            "user_phone_number": getSavedString("user_phone"),
            "user_pottname": getSavedString("user_pott_name"),
            "investor_id": getSavedString("user_id"),
            "app_type": "ios",
            "app_version_code": app_version,
            "user_language": "en",
            "item_type": "stocktransfer",
            "item_id": stockpurchase_id,
            "payment_gateway_status": "1",
            "payment_gateway_info": momo_transaction_with_date
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
                    self.showLoginButton = true;
                    if status == 1 {
                        
                        if let message = json["message"].string {
                            //Now you got your value
                            self.message = message
                                self.processingPayment = 4
                                print("b message: \(message)")
                            
                            
                            if let transactionOrderID = json["data"]["order_id"].string {
                                //Now you got your value
                                self.transactionOrderID = transactionOrderID
                                print("transactionOrderID: \(transactionOrderID)")
                            }
                          }
                        
                    } else {
                        self.processingPayment = 2
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
                self.showLoginButton = true;
                self.message = "Process Failed"
                self.processingPayment = 2
            }
        }
        
    }.resume()
  }
}
