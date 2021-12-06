//
//  DrillQuestionView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/5/21.
//

import SwiftUI

struct DrillQuestionView: View {
    // MARK: - PROPERTIES
    var drillQuestion: String
    var drillAnswer1: String
    var drillAnswer2: String
    var drillAnswer3: String
    var drillAnswer4: String
    
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                VStack(spacing: 20) {
                    // INFO : HEADLINE
                    Text(drillQuestion)
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            ZStack {
                VStack(spacing: 2) {
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text(drillAnswer1)
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .lineLimit(nil)
                    
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text(drillAnswer2)
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .lineLimit(nil)
                    
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text(drillAnswer3)
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .lineLimit(nil)
                    
                    Button(action: {
                        
                        //print("user_firstname: \(self.user_firstname)")
                        //print("user_surname: \(self.user_surname)")
                        //print("user_country: \(self.user_country)")
                        /*
                         if networking == false {
                            networking = true;
                            manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                        }
                         */
                    }) {
                        HStack (spacing: 8) {
                            Text(drillAnswer4)
                                .foregroundColor(Color("ColorWhiteAccent"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorWhiteAccent"))
                    } //: BUTTON
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .accentColor(Color("ColorBlackPrimary"))
                    .background(Color("ColorBlackPrimary"))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                        
                } //  VSTACK
            } //  ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
        } //  VSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
    }
}

struct DrillQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DrillQuestionView(drillQuestion: "You are at the end of a cliff being chased by a lion", drillAnswer1: "I'm jumping", drillAnswer2: "I'm fighting", drillAnswer3: "What else can I do", drillAnswer4: "God help me" )
    }
}


class AnswerDrillSuggestionHttpAuth: ObservableObject {

    @Published var authenticated = 0
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var theDrillSysId: String = ""
    @Published var theDrillQuestion: String = ""
    @Published var theDrillAnswer1: String = ""
    @Published var theDrillAnswer2: String = ""
    @Published var theDrillAnswer3: String = ""
    @Published var theDrillAnswer4: String = ""

func sendRequest(app_version: String) {
    showLoginButton = false
    guard let url = URL(string: "http://144.202.111.61/api/v1/user/get-my-suggestion") else { return }
        
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
                        self.authenticated = 1
                        
                        if let drill_sys_id = json["data"]["drill_sys_id"].string {
                            //Now you got your value
                            saveTextInStorage("drill_sys_id", drill_sys_id)
                            self.theDrillSysId = drill_sys_id
                            print("drill_sys_id: \(drill_sys_id)")
                          }
                        
                        if let drill_question = json["data"]["drill_question"].string {
                            //Now you got your value
                            saveTextInStorage("drill_question", drill_question)
                            self.theDrillQuestion = drill_question
                            print("drill_question: \(drill_question)")
                          }
                        
                        if let drill_answer_1 = json["data"]["drill_answer_1"].string {
                            //Now you got your value
                            saveTextInStorage("drill_answer_1", drill_answer_1)
                            self.theDrillAnswer1 = drill_answer_1
                            print("drill_answer_1: \(drill_answer_1)")
                          }
                        
                        if let drill_answer_2 = json["data"]["drill_answer_2"].string {
                            //Now you got your value
                            saveTextInStorage("drill_answer_2", drill_answer_2)
                            self.theDrillAnswer2 = drill_answer_2
                            print("drill_answer_2: \(drill_answer_2)")
                          }
                        
                        if let drill_answer_3 = json["data"]["drill_answer_3"].string {
                            //Now you got your value
                            saveTextInStorage("drill_answer_3", drill_answer_3)
                            self.theDrillAnswer3 = drill_answer_3
                            print("drill_answer_3: \(drill_answer_3)")
                          }
                        
                        if let drill_answer_4 = json["data"]["drill_answer_4"].string {
                            //Now you got your value
                            saveTextInStorage("drill_answer_4", drill_answer_4)
                            self.theDrillAnswer4 = drill_answer_4
                            print("drill_answer_4: \(drill_answer_4)")
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
