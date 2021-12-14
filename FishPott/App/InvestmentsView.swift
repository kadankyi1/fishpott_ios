//
//  InvestmentsView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI
import SwiftyJSON

struct InvestmentsView: View {
    var body: some View {
        NavigationView {
            if articles_http_manager.requestMade {
                if (articles_http_manager.status == "success"){
                    List {
                        ForEach(articles_http_manager.received_articles) { item in
                            NavigationLink(destination: ArticleDetailView(article: item)){
                                ReadArticleRowView(article: item)
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                } else {
                    VStack {}
                        .alert(isPresented: $model.isValid, content: {
                        Alert(title: Text("Oops"),
                              message: Text("Something went awry"),
                              dismissButton: .default(
                                Text("Okay"))
                                {
                                    //print("do something")
                                    
                                })
                    })
                }
            } else {
                ProgressView()
                .onAppear(perform: {
                    print("Access Token request starting")
                    articles_http_manager.getArticles(user_accesstoken: access_token)
                })
            }
            
        } // NAVIGATION
    }
}

struct InvestmentsView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentsView()
    }
}



class InvestmentFetchHttpAuth: ObservableObject {

    @Published var authenticated = 0
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var received_investments: [InvestmentModel] = []
    
    func sendRequest(business_id: String, app_version: String) {
    showLoginButton = false
        self.authenticated = 3
    guard let url = URL(string: "http://144.202.111.61/api/v1/user/get-my-investments") else { return }
        
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
                //print(status)
                DispatchQueue.main.async {
                    if status == 1 {
                        
                        if let items = json["data"]["data"].array {
                            for item in items {
                                if let article_type = item["article_type"].string {
                                    print(article_type)
                                    if let article_title = item["article_title"].string {
                                        print(article_title)
                                        if let article_body = item["article_body"].string {
                                            print(article_body)
                                            if let created_at = item["created_at"].string {
                                                    print(created_at)
                                                    if let article_image = item["article_image"].string {
                                                        print(article_image)
                                                    if let article_id = item["article_id"].int {
                                                        print(article_id)
                                                        var type_color = "ColorSpecialArticles"
                                                        if(article_type == "HERALD OF GLORY"){
                                                            type_color = "ColorArticleHeraldOfGlory"
                                                        } else if(article_type == "BIBLE READING PLAN"){
                                                            type_color = "ColorBibleReadingPlan"
                                                        } else if(article_type == "GLORY NEWS"){
                                                            type_color = "ColorGloryNews"
                                                        }
                                                        self.authenticated = 4
                                                        self.received_articles.append(ArticleModel(
                                                            article_sku: article_id,
                                                            articletype: article_type,
                                                            title: article_title,
                                                            body: article_body,
                                                            image: article_image,
                                                            badge_color: type_color,
                                                            article_date: created_at
                                                        ))
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
