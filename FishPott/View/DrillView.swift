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
    @ObservedObject var answerDrillSuggestionHttpAuth = AnswerDrillSuggestionHttpAuth()
    
    
    var body: some View {
        if drillStage  == 0 {
            DrillQuestionView(drillID: drillID, drillQuestion: drillQuestion, drillAnswer1: drillAnswer1, drillAnswer2: drillAnswer2, drillAnswer3: drillAnswer3, drillAnswer4: drillAnswer4, suggestionStage: $drillStage)
        } else if answerDrillSuggestionHttpAuth.stage  == 1 {
            DrillAnsweredView(drillQuestion: drillQuestion, drillAnswer1: drillAnswer1, drillAnswer2: drillAnswer2, drillAnswer3: drillAnswer3, drillAnswer4: drillAnswer4, drillAnswer1Count: answerDrillSuggestionHttpAuth.theDrillAnswer1Count, drillAnswer2Count: answerDrillSuggestionHttpAuth.theDrillAnswer2Count, drillAnswer3Count: answerDrillSuggestionHttpAuth.theDrillAnswer3Count, drillAnswer4Count: answerDrillSuggestionHttpAuth.theDrillAnswer4Count)
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
    @Published var theDrillSysId: String = ""
    @Published var theDrillAnswer1Count: String = ""
    @Published var theDrillAnswer2Count: String = ""
    @Published var theDrillAnswer3Count: String = ""
    @Published var theDrillAnswer4Count: String = ""

func sendRequest(drill_id: String, drill_answer: String, app_version: String) {
    networking = 1;
    showLoginButton = false
    guard let url = URL(string: "http://144.202.111.61/api/v1/user/save-drill-answer") else { return }
        
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
                        self.networking = 3;
                        if let message = json["message"].string {
                            //Now you got your value
                              print(message)
                              self.message = message
                        }
                        if let answer_1_count = json["data"]["answer_1_count"].string {
                            //Now you got your value
                            self.theDrillAnswer1Count = answer_1_count
                            print("answer_1_count: \(answer_1_count)")
                        }
                        if let answer_2_count = json["data"]["answer_2_count"].string {
                            //Now you got your value
                            self.theDrillAnswer2Count = answer_2_count
                            print("answer_2_count: \(answer_2_count)")
                        }
                        if let answer_3_count = json["data"]["answer_3_count"].string {
                            //Now you got your value
                            self.theDrillAnswer3Count = answer_3_count
                            print("answer_3_count: \(answer_3_count)")
                        }
                        if let answer_4_count = json["data"]["answer_4_count"].string {
                            //Now you got your value
                            self.theDrillAnswer4Count = answer_4_count
                            print("answer_4_count: \(answer_4_count)")
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
                self.networking = 0;
            }
        }
        
    }.resume()
}
}
