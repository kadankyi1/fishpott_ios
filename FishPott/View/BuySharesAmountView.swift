//
//  BuySharesAmountView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/12/21.
//

import UIKit
import SwiftUI
import URLImage // Import the package module
import SwiftyJSON
import Paystack

struct BuySharesAmountView: View {
    // MARK: - PROPERTIES
    var businessID: String
    var businessName: String
    var businessLogo: String
    var businessCountry: String
    var businessType: String
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State private var shouldRefresh = false
    @State private var keyword: String = ""
    @State private var risk_chosen: String = ""
    @ObservedObject var getFinalPriceHttpAuth = GetFinalPriceHttpAuth()
    @State private var networking: Bool = false
    @State private var lastSelectedIndex: Int?
    @State private var lastSelectedGender: Int?
    @State var risks_array = [
        //"1",
        //"2",
        "3"
    ] //Here Add Your data
    // CC
    @State private var degrees: Double = 0
    @State private var flipped: Bool = false
    
    @State private var transaction_id: String = ""
    @State private var payment_date: String = ""
    
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false){
                if getFinalPriceHttpAuth.authenticated  == 0  || getFinalPriceHttpAuth.authenticated  == 2 {
                    VStack(spacing: 10) {
                        BusinessBannerView(businessID: businessID, businessName: businessName, businessLogo: businessLogo, businessCountry: businessCountry, businessType: businessType)
                        
                        if getFinalPriceHttpAuth.authenticated  == 2 {
                            Text(getFinalPriceHttpAuth.message)
                            .font(.headline)
                            .foregroundColor(.red)
                        }
                        
                        TextField("Investment Amount ($)", text: $keyword).textFieldStyle(RoundedBorderTextFieldStyle.init())
                            .scaleEffect(x: 1, y: 1, anchor: .center)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 20)
                            .padding(.top, 20)
                            .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            
                        PickerTextField(data: [
                            //"100% Risk Protection",
                            //"50% Risk Protection",
                            "No Risk Protection"
                        ],placeholder: "Choose Risk Protection",lastSelectedIndex: self.$lastSelectedGender)
                            .frame(height: 10, alignment: .bottom)
                            .scaleEffect(x: 1, y: 1, anchor: .center)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 20)
                            .padding(.top, 15)
                            .background(GeometryGetter(rect: $kGuardian.rects[0]))
                        
                        Text("Risk insurance is currently not available but we are working with partner insurance companies to provide you with this service")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 20)
                            .padding(.top, 15)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12))
                        
                                Button(action: {
                                    print("FishPottApp.app_version: " + FishPottApp.app_version)
                                    if getFinalPriceHttpAuth.showLoginButton == true {
                                        //networking = true;
                                        risk_chosen = risks_array[lastSelectedGender ?? 0]
                                        getFinalPriceHttpAuth.sendRequest(business_id: businessID, investment_amt_in_dollars: keyword, investment_risk_protection: risk_chosen, app_version: FishPottApp.app_version);
                                        getFinalPriceHttpAuth.authenticated = 3
                                        print("here 1")
                                    }
                                }) {
                                    HStack (spacing: 4) {
                                        Text("Get Summary")
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
                } else if getFinalPriceHttpAuth.authenticated  == 4 {
                        VStack(spacing: 10) {
                            BusinessBannerView(businessID: businessID, businessName: businessName, businessLogo: businessLogo, businessCountry: businessCountry, businessType: businessType)
                            
                            
                            PriceSummaryView(businessName: getFinalPriceHttpAuth.businessName, pricePerItem: getFinalPriceHttpAuth.pricePerItem, quantityToBuy: getFinalPriceHttpAuth.quantityToBuy, dollarToCedisRate: getFinalPriceHttpAuth.dollarToCedisRate, riskStatement: getFinalPriceHttpAuth.riskStatement, riskInsuranceFee: getFinalPriceHttpAuth.riskInsuranceFee, processingFee: getFinalPriceHttpAuth.processingFee, overallTotalUsd: getFinalPriceHttpAuth.overallTotalUsd)
                            
                                    Button(action: {
                                        getFinalPriceHttpAuth.authenticated = 5
                                    }) {
                                        HStack (spacing: 4) {
                                            Text(" Proceed To Payment ")
                                                .foregroundColor(Color("ColorWhiteAccent"))
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 5)
                                        .foregroundColor(Color("ColorWhiteAccent"))
                                    } //: BUTTON
                                    .accentColor(Color("ColorBlackPrimary"))
                                    .background(Color("ColorBlackPrimary"))
                                    .cornerRadius(5)
                                    .padding(.bottom, 20)
                        } //  VSTACK
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(Color.white)
                } else if getFinalPriceHttpAuth.authenticated  == 5 {
                        
                    VStack {
                        
                        PaymentBankTransferView(bankName: <#String#>, bankAddress: <#String#>, bankSwiftIban: <#String#>, bankBranch: <#String#>, accountName: <#String#>, accountNumber: <#String#>, referenceCode: <#String#>)
                        
                        
                        Text("Send " + getFinalPriceHttpAuth.overallTotalUsd + " to the account above and fill the form below")
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
                        
                        if getFinalPriceHttpAuth.processingPayment == 0 || getFinalPriceHttpAuth.processingPayment == 4 || getFinalPriceHttpAuth.processingPayment == 2 {
                            
                            if getFinalPriceHttpAuth.processingPayment == 4 {
                                
                                Text("Transaction recorded successfully and under review. Please write this transaction ID for reference: " + getFinalPriceHttpAuth.transactionOrderID)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal, 50)
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 12))
                            } else if getFinalPriceHttpAuth.processingPayment == 2 {
                                Text(getFinalPriceHttpAuth.message)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal, 50)
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 12))
                            }
                            Button(action: {
                                
                                if(getFinalPriceHttpAuth.processingPayment == 0 || getFinalPriceHttpAuth.processingPayment == 2){
                                    getFinalPriceHttpAuth.sendPaymentRequest(stockpurchase_id: getFinalPriceHttpAuth.orderID, momo_transaction_with_date: "Bank Account Name : " + transaction_id + " - Date: " + payment_date, app_version: FishPottApp.app_version);
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
                        } else if getFinalPriceHttpAuth.processingPayment == 3 {
                                ProgressView()
                        } else if getFinalPriceHttpAuth.processingPayment == 0 {
                            
                        }
                        
                        
                    } //  VSTACK
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                } else if getFinalPriceHttpAuth.authenticated  == 3 {
                    VStack(spacing: 10) {
                        Image("roundlogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 50)
                        Text("Getting Final Price Summary...")
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
                        Text(getFinalPriceHttpAuth.message)
                        .font(.headline)
                        .foregroundColor(.red)
                        .onTapGesture {
                           if networking == false {
                               networking = true;
                               risk_chosen = risks_array[lastSelectedGender ?? 0]
                               getFinalPriceHttpAuth.sendRequest(business_id: businessID, investment_amt_in_dollars: keyword, investment_risk_protection: risk_chosen, app_version: FishPottApp.app_version);
                               getFinalPriceHttpAuth.authenticated = 3
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

struct BuySharesAmountView_Previews: PreviewProvider {
    static var previews: some View {
        BuySharesAmountView(businessID: "ID971730", businessName: "REM FILLING", businessLogo: "", businessCountry: "Ghana", businessType: "Restuarant")
    }
}



class GetFinalPriceHttpAuth: ObservableObject {

    @Published var authenticated = 0
    @Published var processingPayment = 0
    @Published var showLoginButton = true
    @Published var message = ""
    
    @Published var businessName: String = ""
    @Published var pricePerItem: String = ""
    @Published var quantityToBuy: Int = 0
    @Published var dollarToCedisRate: String = ""
    @Published var riskType: String = ""
    @Published var riskStatement: String = ""
    @Published var riskInsuranceFee: String = ""
    @Published var processingFee: String = ""
    @Published var overallTotalUsd: String = ""
    @Published var overallTotalLocalCurrency: String = ""
    @Published var overallTotalLocalCurrencyFloatval: String = ""
    @Published var financialYieldInfo: String = ""
    @Published var orderID: String = ""
    @Published var paymentGatewayCurrency: String = ""
    @Published var paymentGatewayAmt: Int = 0
    @Published var mobileMoneyNumber: String = ""
    @Published var mobileMoneyName: String = ""
    @Published var transactionOrderID: String = ""
    @Published var bankName: String = ""
    @Published var bankAddress: String = ""
    @Published var bankSwiftIban: String = ""
    @Published var bankBranch: String = ""
    @Published var accountName: String = ""
    @Published var accountNumber: String = ""
    @Published var referenceCode: String = ""
    
    func sendRequest(business_id: String, investment_amt_in_dollars: String, investment_risk_protection: String, app_version: String) {
    showLoginButton = false
        self.authenticated = 3
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/get-final-price") else { return }
        
    let body: [String: String] =
        [
            "user_phone_number": getSavedString("user_phone"),
            "user_pottname": getSavedString("user_pott_name"),
            "investor_id": getSavedString("user_id"),
            "app_type": "ios",
            "app_version_code": app_version,
            "user_language": "en",
            "business_id": business_id,
            "investment_amt_in_dollars": investment_amt_in_dollars,
            "investment_risk_protection": investment_risk_protection
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
                                self.authenticated = 4
                                print("b message: \(message)")
                            
                            if let businessName = json["data"]["item"].string {
                              //Now you got your value
                              self.businessName = businessName
                              print("businessName: \(businessName)")
                            }
                            
                            if let pricePerItem = json["data"]["price_per_item"].string {
                                //Now you got your value
                                self.pricePerItem = pricePerItem
                                print("pricePerItem: \(pricePerItem)")
                            }
                            
                            if let quantityToBuy = json["data"]["quantity"].int {
                                //Now you got your value
                                self.quantityToBuy = quantityToBuy
                                print("quantity: \(quantityToBuy)")
                            }
                            
                            if let dollarToCedisRate = json["data"]["rate"].string {
                                //Now you got your value
                                self.dollarToCedisRate = dollarToCedisRate
                                print("dollarToCedisRate: \(dollarToCedisRate)")
                            }
                            
                            if let riskType = json["data"]["risk"].string {
                                //Now you got your value
                                self.riskType = riskType
                                print("riskType: \(riskType)")
                            }
                            
                            if let riskStatement = json["data"]["risk_statement"].string {
                                //Now you got your value
                                self.riskStatement = riskStatement
                                print("riskStatement: \(riskStatement)")
                            }
                            
                            if let riskInsuranceFee = json["data"]["risk_insurance_fee"].string {
                                //Now you got your value
                                self.riskInsuranceFee = riskInsuranceFee
                                print("riskInsuranceFee: \(riskInsuranceFee)")
                            }
                            
                            if let processingFee = json["data"]["processing_fee"].string {
                                //Now you got your value
                                self.processingFee = processingFee
                                print("processingFee: \(processingFee)")
                            }
                            
                            if let overallTotalUsd = json["data"]["overall_total_usd"].string {
                                //Now you got your value
                                self.overallTotalUsd = overallTotalUsd
                                print("overallTotalUsd: \(overallTotalUsd)")
                            }
                            
                            if let overallTotalLocalCurrency = json["data"]["overall_total_local_currency"].string {
                                //Now you got your value
                                self.overallTotalLocalCurrency = overallTotalLocalCurrency
                                print("overallTotalLocalCurrency: \(overallTotalLocalCurrency)")
                            }
                            
                            if let overallTotalLocalCurrencyFloatval = json["data"]["overall_total_local_currency_floatval"].string {
                                //Now you got your value
                                self.overallTotalLocalCurrencyFloatval = overallTotalLocalCurrencyFloatval
                                print("overallTotalLocalCurrencyFloatval: \(overallTotalLocalCurrencyFloatval)")
                            }
                            
                            if let financialYieldInfo = json["data"]["financial_yield_info"].string {
                                //Now you got your value
                                self.financialYieldInfo = financialYieldInfo
                                print("financialYieldInfo: \(financialYieldInfo)")
                            }
                            
                            if let orderID = json["data"]["order_id"].string {
                                //Now you got your value
                                self.orderID = orderID
                                print("orderID: \(orderID)")
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
                self.showLoginButton = true;
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
            "item_type": "stockpurchase",
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


class ViewController: UIViewController {
    var strings: [String]!
    
}


func charge(cardParams: PSTCKCardParams, viewController: UIViewController, currency: String, email: String, reference: String, amount: UInt) {
    // cardParams already fetched from our view or assembled by you
    let transactionParams = PSTCKTransactionParams.init();

    // building new Paystack Transaction
    transactionParams.amount = amount;
    transactionParams.currency = currency;
    transactionParams.email = email;
    transactionParams.reference = reference;
    let custom_filters: NSMutableDictionary = [
        "recurring": false
    ];
    let items: NSMutableArray = [
        "Bag","Glasses"
    ];
    do {
        
        try transactionParams.setCustomFieldValue("iOS SDK", displayedAs: "Paid Via");
        /*
        try transactionParams.setCustomFieldValue("iOS SDK", displayedAs: "Paid Via");
        try transactionParams.setCustomFieldValue("Paystack hats", displayedAs: "To Buy");
        try transactionParams.setMetadataValue("iOS SDK", forKey: "paid_via");
        try transactionParams.setMetadataValueDict(custom_filters, forKey: "custom_filters");
        try transactionParams.setMetadataValueArray(items, forKey: "items");
        try transactionParams.setMetadataValueArray(items, forKey: "items");
         */
    } catch {
        print(error);
    }
    transactionParams.email = "e@ma.il";

    // check https://developers.paystack.co/docs/split-payments-overview for details on how these work
    // transactionParams.subaccount  = "ACCT_80d907euhish8d";
    // transactionParams.bearer  = "subaccount";
    // transactionParams.transaction_charge  = 280;

    // if a reference is not supplied, we will give one
    // transactionParams.reference = "ChargedFromiOSSDK@"

    PSTCKAPIClient.shared().chargeCard(cardParams, forTransaction: transactionParams, on: viewController,
               didEndWithError: { (error, reference) -> Void in
                //handleError(error)
                print(error);
            }, didRequestValidation: { (reference) -> Void in
                // an OTP was requested, transaction has not yet succeeded
            }, didTransactionSuccess: { (reference) -> Void in
                // transaction may have succeeded, please verify on backend
        })
}



