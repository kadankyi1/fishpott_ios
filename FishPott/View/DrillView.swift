//
//  DrillQuestionView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/5/21.
//

import SwiftUI
import SwiftyJSON

struct DrillView: View {
    // MARK: - PROPERTIES
    var drillID: String
    var drillQuestion: String
    var drillAnswer1: String
    var drillAnswer2: String
    var drillAnswer3: String
    var drillAnswer4: String
    @State var drillStage = 0
    @State var theDrillAnswer1Count = ""
    @State var theDrillAnswer2Count = ""
    @State var theDrillAnswer3Count = ""
    @State var theDrillAnswer4Count = ""
    
    
    var body: some View {
        if drillStage  == 0 {
            DrillQuestionView(drillID: drillID, drillQuestion: drillQuestion, drillAnswer1: drillAnswer1, drillAnswer2: drillAnswer2, drillAnswer3: drillAnswer3, drillAnswer4: drillAnswer4, drillStage: $drillStage, theDrillAnswer1Count: $theDrillAnswer1Count, theDrillAnswer2Count: $theDrillAnswer2Count, theDrillAnswer3Count: $theDrillAnswer3Count, theDrillAnswer4Count: $theDrillAnswer4Count)
        } else if drillStage  == 1 { 
            DrillAnsweredView(drillQuestion: drillQuestion, drillAnswer1: drillAnswer1, drillAnswer2: drillAnswer2, drillAnswer3: drillAnswer3, drillAnswer4: drillAnswer4, drillAnswer1Count: theDrillAnswer1Count, drillAnswer2Count: theDrillAnswer2Count, drillAnswer3Count: theDrillAnswer3Count, drillAnswer4Count: theDrillAnswer4Count)
        }
    }
}

struct DrillView_Previews: PreviewProvider {
    static var previews: some View {
        DrillView(drillID: "testid", drillQuestion: "You are at the end of a cliff being chased by a lion", drillAnswer1: "I'm jumping", drillAnswer2: "I'm fighting", drillAnswer3: "What else can I do", drillAnswer4: "God help me", drillStage: 0 )
    }
}


class AnswerDrillSuggestionHttpAuth: ObservableObject {

    @Published var stage = 0
    @Published var networking = 0
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var theDrillSysId = ""
    @Published var theDrillAnswer1Count = ""
    @Published var theDrillAnswer2Count = ""
    @Published var theDrillAnswer3Count = ""
    @Published var theDrillAnswer4Count = ""

func sendRequest(drill_id: String, drill_answer: String, app_version: String) {
    networking = 1
    showLoginButton = false
    guard let url = URL(string: FishPottApp.app_domain + "/api/v1/user/save-drill-answer") else { return }
        
    let body: [String: String] =
        [
            "user_phone_number": getSavedString("user_phone"),
            "user_pottname": getSavedString("user_pott_name"),
            "investor_id": getSavedString("user_id"),
            "app_type": "ios",
            "app_version_code": app_version,
            "user_language": "en",
            "drill_id": drill_id,
            "drill_answer": drill_answer
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
                        print("status pass")
                        self.stage = 1
                        self.networking = 2
                        print("CHECK answer_1_count: \(json["data"]["answer_1_count"])")
                        print("CHECK answer_2_count: \(json["data"]["answer_2_count"])")
                        print("CHECK answer_3_count: \(json["data"]["answer_3_count"])")
                        print("CHECK answer_4_count: \(json["data"]["answer_4_count"])")
                        
                         if let answer_1_count = json["data"]["answer_1_count"].int {
                            //Now you got your value
                            self.theDrillAnswer1Count = String(answer_1_count)
                            print("-answer_1_count: \(answer_1_count)")
                        }
                        if let answer_2_count = json["data"]["answer_2_count"].int {
                            //Now you got your value
                            self.theDrillAnswer2Count = String(answer_2_count)
                            print("-answer_2_count: \(answer_2_count)")
                        }
                        if let answer_3_count = json["data"]["answer_3_count"].int {
                            //Now you got your value
                            self.theDrillAnswer3Count = String(answer_3_count)
                            print("-answer_3_count: \(answer_3_count)")
                        }
                        if let answer_4_count = json["data"]["answer_4_count"].int {
                            //Now you got your value
                            self.theDrillAnswer4Count = String(answer_4_count)
                            print("-answer_4_count: \(answer_4_count)")
                        }
                        if let message = json["message"].string {
                            //Now you got your value
                              print(message)
                              self.message = message
                        }
                        
                    } else {
                        self.stage = 0
                        if let message = json["message"].string {
                            //Now you got your value
                            print("status fail")
                            print(message)
                              self.message = message
                          }
                    }
                }
            } // END if let status = json["status"].in
        } catch  let error as NSError {
            print((error as NSError).localizedDescription)
            DispatchQueue.main.async {
                self.message = "Answering Failed"
                self.stage = 2
                self.networking = 0
            }
        }
        
    }.resume()
}
}
