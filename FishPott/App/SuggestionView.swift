//
//  SuggestionView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct SuggestionView: View {
    // MARK: - PROPERTIES
    @State private var shouldRefresh = false
    @ObservedObject var getSuggestionHttpAuth = GetSuggestionHttpAuth()
    //@State private var networking: Bool = false
    
    
    var body: some View {
        
    NavigationView {
        ScrollView(.vertical, showsIndicators: false){
            if getSuggestionHttpAuth.authenticated  == 0{
                VStack(spacing: 10) {
                    Image("roundlogo")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .top)
                            .padding(.vertical, 50)
                    Text("Click here to get a suggestion")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .onTapGesture {
                        if getSuggestionHttpAuth.authenticated == 0 || getSuggestionHttpAuth.authenticated == 2 {
                           getSuggestionHttpAuth.sendRequest(app_version: FishPottApp.app_version);
                           getSuggestionHttpAuth.authenticated = 3
                           print("here 1")
                       }
                    }
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .background(Color.white)
            } else if getSuggestionHttpAuth.authenticated  == 1 { // DRILL
                DrillView(drillID: getSuggestionHttpAuth.theDrillSysId, drillQuestion: getSuggestionHttpAuth.theDrillQuestion, drillAnswer1: getSuggestionHttpAuth.theDrillAnswer1, drillAnswer2: getSuggestionHttpAuth.theDrillAnswer2, drillAnswer3: getSuggestionHttpAuth.theDrillAnswer3, drillAnswer4: getSuggestionHttpAuth.theDrillAnswer4, drillStage: 0)
            } else if getSuggestionHttpAuth.authenticated  == 4 { // BUSINESS
                BusinessView(businessID: getSuggestionHttpAuth.businessID, businessName: getSuggestionHttpAuth.businessName, businessCountry: getSuggestionHttpAuth.businessCountry, businessFindCode: getSuggestionHttpAuth.businessFindCode, businessType: getSuggestionHttpAuth.businessType, businessLogo: getSuggestionHttpAuth.businessLogo, businessDescription: getSuggestionHttpAuth.businessDescription, businessAddress: getSuggestionHttpAuth.businessAddress, businessStartDate: getSuggestionHttpAuth.businessStartDate, businessWebsite: getSuggestionHttpAuth.businessWebsite, businessPitchText: getSuggestionHttpAuth.businessPitchText, businessPitchVideo: getSuggestionHttpAuth.businessPitchVideo, businessLastYrRevenue: getSuggestionHttpAuth.businessLastYrRevenue, businessLastYrProfit: getSuggestionHttpAuth.businessLastYrProfit, businessDebt: getSuggestionHttpAuth.businessDebt, businessCashOnHand: getSuggestionHttpAuth.businessCashOnHand, businessNetWorth: getSuggestionHttpAuth.businessNetWorth, businessPricePerStock: getSuggestionHttpAuth.businessPricePerStock, businessInvestmentAmtNeeded: getSuggestionHttpAuth.businessInvestmentAmtNeeded, businessInvestmentAmtReceived: getSuggestionHttpAuth.businessInvestmentAmtReceived, businessMaxInvestorsNeeded: getSuggestionHttpAuth.businessMaxInvestorsNeeded, businessCurrentShareholders: getSuggestionHttpAuth.businessCurrentShareholders, businessFinancialReport: getSuggestionHttpAuth.businessFinancialReport, businessFinancialReportBio: getSuggestionHttpAuth.businessFinancialReportBio, businessCeoName: getSuggestionHttpAuth.businessCeoName, businessCfoName: getSuggestionHttpAuth.businessCfoName)
            } else if getSuggestionHttpAuth.authenticated  == 3 {
                    VStack(spacing: 10) {
                        Image("roundlogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 50)
                        Text("Fetching Suggestion...")
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
                    Text(getSuggestionHttpAuth.message)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .onTapGesture {
                        if getSuggestionHttpAuth.authenticated == 0 || getSuggestionHttpAuth.authenticated == 2 {
                           getSuggestionHttpAuth.sendRequest(app_version: FishPottApp.app_version);
                           getSuggestionHttpAuth.authenticated = 3
                           print("here new 1")
                       }
                    }
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
            }// MARK - if manager.authenticated
        } // SCROLLVIEW
        .navigationBarTitle("", displayMode: .inline)
      } // NAVIGATION
        
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionView()
    }
}


class GetSuggestionHttpAuth: ObservableObject {

    @Published var authenticated = 0
    @Published var showLoginButton = true
    @Published var message = ""
    
    @Published var theDrillSysId: String = ""
    @Published var theDrillQuestion: String = ""
    @Published var theDrillAnswer1: String = ""
    @Published var theDrillAnswer2: String = ""
    @Published var theDrillAnswer3: String = ""
    @Published var theDrillAnswer4: String = ""

    @Published var businessID: String = ""
    @Published var businessName: String = ""
    @Published var businessCountry: String = ""
    @Published var businessFindCode: String = ""
    @Published var businessType: String = ""
    @Published var businessLogo: String = ""
    @Published var businessDescription: String = ""
    @Published var businessAddress: String = ""
    @Published var businessStartDate: String = ""
    @Published var businessWebsite: String = ""
    @Published var businessPitchText: String = ""
    @Published var businessPitchVideo: String = ""
    @Published var businessLastYrRevenue: String = ""
    @Published var businessLastYrProfit: String = ""
    @Published var businessDebt: String = ""
    @Published var businessCashOnHand: String = ""
    @Published var businessNetWorth: String = ""
    @Published var businessPricePerStock: String = ""
    @Published var businessInvestmentAmtNeeded: String = ""
    @Published var businessInvestmentAmtReceived: String = ""
    @Published var businessMaxInvestorsNeeded: String = ""
    @Published var businessCurrentShareholders: String = ""
    @Published var businessFinancialReport: String = ""
    @Published var businessFinancialReportBio: String = ""
    @Published var businessCeoName: String = ""
    @Published var businessCfoName: String = ""
    
func sendRequest(app_version: String) {
    showLoginButton = false
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/get-my-suggestion") else { return }
        
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
                        
                        if let message = json["message"].string {
                            //Now you got your value
                            self.message = message
                            if message == "drill" {
                                self.authenticated = 1
                                print("d message: \(message)")
                                
                              
                              if let drill_sys_id = json["data"]["drill_sys_id"].string {
                                  //Now you got your value
                                  self.theDrillSysId = drill_sys_id
                                  print("drill_sys_id: \(drill_sys_id)")
                                }
                              
                              if let drill_question = json["data"]["drill_question"].string {
                                  //Now you got your value
                                  self.theDrillQuestion = drill_question
                                  print("drill_question: \(drill_question)")
                                }
                              
                              if let drill_answer_1 = json["data"]["drill_answer_1"].string {
                                  //Now you got your value
                                  self.theDrillAnswer1 = drill_answer_1
                                  print("drill_answer_1: \(drill_answer_1)")
                                }
                              
                              if let drill_answer_2 = json["data"]["drill_answer_2"].string {
                                  //Now you got your value
                                  self.theDrillAnswer2 = drill_answer_2
                                  print("drill_answer_2: \(drill_answer_2)")
                                }
                              
                              if let drill_answer_3 = json["data"]["drill_answer_3"].string {
                                  //Now you got your value
                                  self.theDrillAnswer3 = drill_answer_3
                                  print("drill_answer_3: \(drill_answer_3)")
                                }
                              
                              if let drill_answer_4 = json["data"]["drill_answer_4"].string {
                                  //Now you got your value
                                  self.theDrillAnswer4 = drill_answer_4
                                  print("drill_answer_4: \(drill_answer_4)")
                                }
                                
                            } else if message == "business" {
                                self.authenticated = 4
                                print("b message: \(message)")
                                
                              
                                if let businessID = json["data"]["business_sys_id"].string {
                                  //Now you got your value
                                  self.businessID = businessID
                                  print("businessID: \(businessID)")
                                }
                                
                                if let businessID = json["data"]["business_sys_id"].string {
                                    //Now you got your value
                                    self.businessID = businessID
                                    print("businessID: \(businessID)")
                                  }
                                
                                if let businessName = json["data"]["business_full_name"].string {
                                    //Now you got your value
                                    self.businessName = businessName
                                    print("businessName: \(businessName)")
                                  }
                                
                                if let businessCountry = json["data"]["business_country"].string {
                                    //Now you got your value
                                    self.businessCountry = businessCountry
                                    print("businessCountry: \(businessCountry)")
                                  }
                                
                                if let businessFindCode = json["data"]["business_find_code"].string {
                                    //Now you got your value
                                    self.businessFindCode = businessFindCode
                                    print("businessFindCode: \(businessFindCode)")
                                  }
                                
                                if let businessType = json["data"]["business_type"].string {
                                    //Now you got your value
                                    self.businessType = businessType
                                    print("businessType: \(businessType)")
                                  }
                                
                                if let businessLogo = json["data"]["business_logo"].string {
                                    //Now you got your value
                                    self.businessLogo = businessLogo
                                    print("businessLogo: \(businessLogo)")
                                  }
                                
                                if let businessDescription = json["data"]["business_descriptive_bio"].string {
                                    //Now you got your value
                                    self.businessDescription = businessDescription
                                    print("businessDescription: \(businessDescription)")
                                  }
                                
                                if let businessAddress = json["data"]["business_address"].string {
                                    //Now you got your value
                                    self.businessAddress = businessAddress
                                    print("businessAddress: \(businessAddress)")
                                  }
                                
                                if let businessStartDate = json["data"]["business_start_date"].string {
                                    //Now you got your value
                                    self.businessStartDate = businessStartDate
                                    print("businessStartDate: \(businessStartDate)")
                                  }
                                
                                if let businessWebsite = json["data"]["business_website"].string {
                                    //Now you got your value
                                    self.businessWebsite = businessWebsite
                                    print("businessWebsite: \(businessWebsite)")
                                  }
                                
                                if let businessPitchText = json["data"]["business_pitch_text"].string {
                                    //Now you got your value
                                    self.businessPitchText = businessPitchText
                                    print("businessPitchText: \(businessPitchText)")
                                  }
                                
                                if let businessPitchVideo = json["data"]["business_pitch_video"].string {
                                    //Now you got your value
                                    self.businessPitchVideo = businessPitchVideo
                                    print("businessPitchVideo: \(businessPitchVideo)")
                                  }
                                
                                if let businessLastYrRevenue = json["data"]["business_lastyr_revenue_usd"].string {
                                    //Now you got your value
                                    self.businessLastYrRevenue = businessLastYrRevenue
                                    print("businessLastYrRevenue: \(businessLastYrRevenue)")
                                  }
                                
                                if let businessLastYrProfit = json["data"]["business_address"].string {
                                    //Now you got your value
                                    self.businessLastYrProfit = businessLastYrProfit
                                    print("businessLastYrProfit: \(businessLastYrProfit)")
                                  }
                                
                                if let businessDebt = json["data"]["business_debt_usd"].string {
                                    //Now you got your value
                                    self.businessDebt = businessDebt
                                    print("businessDebt: \(businessDebt)")
                                  }
                                
                                if let businessCashOnHand = json["data"]["business_cash_on_hand_usd"].string {
                                    //Now you got your value
                                    self.businessCashOnHand = businessCashOnHand
                                    print("businessCashOnHand: \(businessCashOnHand)")
                                  }
                                
                                if let businessNetWorth = json["data"]["business_net_worth_usd"].string {
                                    //Now you got your value
                                    self.businessNetWorth = businessNetWorth
                                    print("businessNetWorth: \(businessNetWorth)")
                                  }
                                
                                if let businessPricePerStock = json["data"]["business_price_per_stock_usd"].string {
                                    //Now you got your value
                                    self.businessPricePerStock = businessPricePerStock
                                    print("businessPricePerStock: \(businessPricePerStock)")
                                  }
                                
                                if let businessInvestmentAmtNeeded = json["data"]["business_investments_amount_needed_usd"].string {
                                    //Now you got your value
                                    self.businessInvestmentAmtNeeded = businessInvestmentAmtNeeded
                                    print("businessInvestmentAmtNeeded: \(businessInvestmentAmtNeeded)")
                                  }
                                
                                if let businessInvestmentAmtReceived = json["data"]["business_investments_amount_received_usd"].string {
                                    //Now you got your value
                                    self.businessInvestmentAmtReceived = businessInvestmentAmtReceived
                                    print("businessInvestmentAmtReceived: \(businessInvestmentAmtReceived)")
                                  }
                                
                                if let businessMaxInvestorsNeeded = json["data"]["business_maximum_number_of_investors_allowed"].string {
                                    //Now you got your value
                                    self.businessMaxInvestorsNeeded = businessMaxInvestorsNeeded
                                    print("businessMaxInvestorsNeeded: \(businessMaxInvestorsNeeded)")
                                  }
                                
                                if let businessCurrentShareholders = json["data"]["business_current_shareholders"].int {
                                    //Now you got your value
                                    self.businessCurrentShareholders = String(businessCurrentShareholders)
                                    print("businessCurrentShareholders: \(businessCurrentShareholders)")
                                  }
                                
                                if let businessFinancialReport = json["data"]["business_full_financial_report_pdf_url"].string {
                                    //Now you got your value
                                    self.businessFinancialReport = businessFinancialReport
                                    print("businessFinancialReport: \(businessFinancialReport)")
                                  }
                                
                                if let businessFinancialReportBio = json["data"]["business_descriptive_financial_bio"].string {
                                    //Now you got your value
                                    self.businessFinancialReportBio = businessFinancialReportBio
                                    print("businessFinancialReportBio: \(businessFinancialReportBio)")
                                  }
                                
                                if let businessCeoFirstName = json["data"]["business_executive1_firstname"].string {
                                    //Now you got your value
                                    print("businessCeoFirstName: \(businessCeoFirstName)")
                                    
                                    if let businessCeoLastName = json["data"]["business_executive1_lastname"].string {
                                        //Now you got your value
                                        self.businessCeoName = businessCeoFirstName + " " + businessCeoLastName
                                        print("businessCeoLastName: \(businessCeoLastName)")
                                        print("businessCeoName: \(self.businessCeoName)")
                                      }
                                  }
                                
                                if let businessCfoFirstName = json["data"]["business_executive2_firstname"].string {
                                    //Now you got your value
                                    print("businessCfoFirstName: \(businessCfoFirstName)")
                                    
                                    if let businessCfoLastName = json["data"]["business_executive2_lastname"].string {
                                        //Now you got your value
                                        self.businessCfoName = businessCfoFirstName + " " + businessCfoLastName
                                        print("businessCeoLastName: \(businessCfoLastName)")
                                        print("businessCfoName: \(self.businessCfoName)")
                                      }
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
