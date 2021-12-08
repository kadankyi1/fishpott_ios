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
    @State private var networking: Bool = false
    
    
    var body: some View {
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
                       if networking == false {
                           networking = true;
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
            } else if getSuggestionHttpAuth.authenticated  == 1 { // BUSINESS
                //DrillView(drillID: getSuggestionHttpAuth.theDrillSysId, drillQuestion: getSuggestionHttpAuth.theDrillQuestion, drillAnswer1: getSuggestionHttpAuth.theDrillAnswer1, drillAnswer2: getSuggestionHttpAuth.theDrillAnswer2, drillAnswer3: getSuggestionHttpAuth.theDrillAnswer3, drillAnswer4: getSuggestionHttpAuth.theDrillAnswer4)
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
                    .foregroundColor(.red)
                    .onTapGesture {
                       if networking == false {
                           networking = true;
                           getSuggestionHttpAuth.sendRequest(app_version: FishPottApp.app_version);
                           getSuggestionHttpAuth.authenticated = 3
                           print("here new 1")
                       }
                    }
                } //  VSTACK
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 600, idealHeight: 600, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
            }// MARK - if manager.authenticated
        }
        
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
