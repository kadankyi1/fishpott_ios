//
//  BuySharesAmountView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/12/21.
//

import SwiftUI
import URLImage // Import the package module
import SwiftyJSON

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
    @State var risks_array = ["1","2", "3"] //Here Add Your data
    
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false){
                if getFinalPriceHttpAuth.authenticated  == 0 {
                    VStack(spacing: 10) {
                        BusinessBannerView(businessID: businessID, businessName: businessName, businessLogo: businessLogo, businessCountry: businessCountry, businessType: businessType)
                        
                        TextField("Investment Amount ($)", text: $keyword).textFieldStyle(RoundedBorderTextFieldStyle.init())
                            .scaleEffect(x: 1, y: 1, anchor: .center)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 20)
                            .padding(.top, 20)
                            .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            
                        PickerTextField(data: ["100% Risk Protection", "50% Risk Protection", "No Risk Protection"],placeholder: "Choose Risk Protection",lastSelectedIndex: self.$lastSelectedGender)
                            .frame(height: 10, alignment: .bottom)
                            .scaleEffect(x: 1, y: 1, anchor: .center)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 20)
                            .padding(.top, 15)
                            .background(GeometryGetter(rect: $kGuardian.rects[0]))
                        
                                Button(action: {
                                    print("FishPottApp.app_version: " + FishPottApp.app_version)
                                    if networking == false {
                                        networking = true;
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
                                        print("FishPottApp.app_version: " + FishPottApp.app_version)
                                        if networking == false {
                                            networking = true;
                                            risk_chosen = risks_array[lastSelectedGender ?? 0]
                                            getFinalPriceHttpAuth.sendRequest(business_id: businessID, investment_amt_in_dollars: keyword, investment_risk_protection: risk_chosen, app_version: FishPottApp.app_version);
                                            getFinalPriceHttpAuth.authenticated = 3
                                            print("here 1")
                                        }
                                    }) {
                                        HStack (spacing: 4) {
                                            Text(" Buy ")
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
                    if status == 1 {
                        
                        if let message = json["message"].string {
                            //Now you got your value
                            self.message = message
                            if message == "business" {
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
                                
                            } else {
                                self.authenticated = 2
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
}

