//
//  FinderView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct FinderView: View {
    // MARK: - PROPERTIES
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State private var shouldRefresh = false
    @State private var keyword: String = ""
    @ObservedObject var finderSearchItemHttpAuth = FinderSearchItemHttpAuth()
    @State private var networking: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            if finderSearchItemHttpAuth.authenticated  == 0{
                VStack(spacing: 10) {
                TextField("Find Code", text: $keyword).textFieldStyle(RoundedBorderTextFieldStyle.init())
                    .scaleEffect(x: 1, y: 1, anchor: .center)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 10)
                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                        Button(action: {
                            print("FishPottApp.app_version: " + FishPottApp.app_version)
                            if networking == false {
                                networking = true;
                                finderSearchItemHttpAuth.sendRequest(business_id: keyword, app_version: FishPottApp.app_version);
                                finderSearchItemHttpAuth.authenticated = 3
                                print("here 1")
                            }
                        }) {
                            HStack (spacing: 4) {
                                Text("Find")
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
            } else if finderSearchItemHttpAuth.authenticated  == 1 {
                BusinessView(businessID: "testID", businessName: "Randy Pharmacy", businessCountry: "Ghana", businessFindCode: "TT-282201", businessType: "Pharmacy", businessLogo: "startinfo2", businessDescription: "This is a good business that has been around for over 15 years", businessAddress: "C/11, Taxi Rank, Madina - CD19991", businessStartDate: "Jan 12, 2005", businessWebsite: "https://github.com/kadankyi1?tab=overview", businessPitchText: "Be part of the sprout. You will love it", businessPitchVideo: "http://144.202.111.61/uploads/pitchvideos/CS201720810.mp4", businessLastYrRevenue: "$299,999", businessLastYrProfit: "$100,000", businessDebt: "0", businessCashOnHand: "$156000", businessNetWorth: "$300,500", businessPricePerStock: "$300", businessInvestmentAmtNeeded: "$100,000", businessInvestmentAmtReceived: "$35,000", businessMaxInvestorsNeeded: "20", businessCurrentShareholders: "10", businessFinancialReport: "http://144.202.111.61/uploads/financedata/CS201720810.pdf",businessFinancialReportBio: "This is business is picking up.", businessCeoName: "Emelia Saint", businessCfoName: "Sanctum Heyst")
            } else if finderSearchItemHttpAuth.authenticated  == 3 {
                    VStack(spacing: 10) {
                        Image("roundlogo")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .top)
                                .padding(.vertical, 50)
                        Text("Finding Item...")
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
                    Text(finderSearchItemHttpAuth.message)
                    .font(.headline)
                    .foregroundColor(.red)
                    .onTapGesture {
                       if networking == false {
                           networking = true;
                           finderSearchItemHttpAuth.sendRequest(business_id: keyword, app_version: FishPottApp.app_version);
                           finderSearchItemHttpAuth.authenticated = 3
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

struct FinderView_Previews: PreviewProvider {
    static var previews: some View {
        FinderView()
    }
}


class FinderSearchItemHttpAuth: ObservableObject {

    @Published var authenticated = 0
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var theDrillSysId: String = ""
    @Published var theDrillQuestion: String = ""
    @Published var theDrillAnswer1: String = ""
    @Published var theDrillAnswer2: String = ""
    @Published var theDrillAnswer3: String = ""
    @Published var theDrillAnswer4: String = ""

func sendRequest(business_id: String, app_version: String) {
    authenticated = 3
    showLoginButton = false
    guard let url = URL(string: "http://144.202.111.61/api/v1/user/find-business") else { return }
        
    let body: [String: String] =
        [
            "user_phone_number": getSavedString("user_phone"),
            "user_pottname": getSavedString("user_pott_name"),
            "investor_id": getSavedString("user_id"),
            "app_type": "ios",
            "app_version_code": app_version,
            "user_language": "en",
            "business_id": business_id
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
                        self.authenticated = 1
                        
                        if let drill_sys_id = json["data"]["drill_sys_id"].string {
                            //Now you got your value
                            saveTextInStorage("drill_sys_id", drill_sys_id)
                            self.theDrillSysId = drill_sys_id
                            print("drill_sys_id: \(drill_sys_id)")
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
                self.message = "Finder failed."
                self.authenticated = 2
            }
        }
        
    }.resume()
}
}
