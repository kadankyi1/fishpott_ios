//
//  LoginView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/20/21.
//

import SwiftUI
import SwiftyJSON

struct LoginView: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State private var name = Array<String>.init(repeating: "", count: 3)

    @State private var username: String = ""
    @State private var password: String = ""
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager = HttpAuth()
    @ObservedObject var updateContent2 = HttpUpdateContentForLogin()
    @Binding var currentStage: String
    @State private var networking: Bool = false
        
        
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            
            Image("roundlogo")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .top)
                    .padding(.vertical, 50)
            
            if manager.requestMade {
                if !manager.authenticated {
                    Text(manager.message)
                    .font(.headline)
                    .foregroundColor(.red)
                        .onAppear(perform: {
                                networking = false;
                        })
                } else {
                    Text("Login Successful")
                    .font(.headline)
                    .foregroundColor(.green)
                    .onAppear(perform: {
                        saveTextInStorage("user_phone", manager.user_phone)
                        saveTextInStorage("user_id", manager.user_id)
                        saveTextInStorage("access_token", manager.access_token)
                        saveTextInStorage("user_pott_name", manager.user_pott_name)
                        saveTextInStorage("user_full_name", manager.user_full_name)
                        saveTextInStorage("user_profile_picture", manager.user_profile_picture)
                        saveTextInStorage("user_country", manager.user_country)
                        saveIntegerInStorage("user_verified_status", manager.user_verified_status)
                        saveTextInStorage("user_type", manager.user_type)
                        saveTextInStorage("user_gender", manager.user_gender)
                        saveTextInStorage("user_date_of_birth", manager.user_date_of_birth)
                        saveTextInStorage("user_currency", manager.user_currency)
                        //saveTextInStorage("id_verification_is_on", manager.id_verification_is_on)
                        saveIntegerInStorage("user_min_allowed_version", manager.user_min_allowed_version)
                        saveTextInStorage("mtn_momo_number", manager.mtn_momo_number)
                        saveTextInStorage("mtn_momo_acc_name", manager.mtn_momo_acc_name)
                        saveTextInStorage("vodafone_momo_number", manager.vodafone_momo_number)
                        saveTextInStorage("vodafone_momo_acc_name", manager.vodafone_momo_acc_name)
                        saveTextInStorage("airteltigo_momo_number", manager.airteltigo_momo_number)
                        saveTextInStorage("airteltigo_momo_acc_name", manager.airteltigo_momo_acc_name)
                        self.currentStage = "MainView"
                        print("currentStage: \(self.currentStage)")
                    })
                }
            } // MARK - if manager.requestMade
 
            
            TextField("Phone Number", text: $username).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
                .background(GeometryGetter(rect: $kGuardian.rects[0]))
                //.position(x: 1, y: 1)
            
            
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .top)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
                .background(GeometryGetter(rect: $kGuardian.rects[1]))
            
            if manager.showLoginButton {
                Button(action: {
                    print("\(self.username) and \(self.password)")
                    if networking == false {
                        networking = true;
                        manager.checkDetails(user_phone_number: self.username, password: self.password)
                    }
                    
                }) {
                    HStack (spacing: 8) {
                        Text("LOGIN")
                            .foregroundColor(Color("ColorWhiteAccent"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .foregroundColor(Color("ColorWhiteAccent"))
                } //: BUTTON
                .accentColor(Color("ColorBlackPrimary"))
                .background(Color("ColorBlackPrimary"))
                .cornerRadius(5)
                .padding(.bottom, 50)
                
            } // MARK - if manager.showLoginButton
            else {
                ProgressView()
            }
            
            
            Text("Start A FishPott")
                .foregroundColor(Color("ColorBlackPrimary"))
                .padding(.bottom, 10)
                .onTapGesture {
                    self.currentStage = "SignupView"
                }
            
            Text("Privacy Policy | Terms & Conditions")
                .foregroundColor(Color("ColorGray"))
                .padding(.bottom, 10)
                .onTapGesture {
                    self.currentStage = "SignupView"
                }
            
            
        } // MARK - VSTACK
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentStage: .constant("LoginView"))
    }
}


class HttpAuth: ObservableObject {

    @Published var authenticated = false
    @Published var requestMade = false
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var user_phone = ""
    @Published var user_id = ""
    @Published var access_token = ""
    @Published var user_pott_name = ""
    @Published var user_full_name = ""
    @Published var user_profile_picture = ""
    @Published var user_country = ""
    @Published var user_verified_status = 0
    @Published var user_type = ""
    @Published var user_gender = ""
    @Published var user_date_of_birth = ""
    @Published var user_currency = ""
    //@Published var id_verification_is_on = false
    @Published var media_allowed = 0
    @Published var user_min_allowed_version = 0
    @Published var mtn_momo_number = ""
    @Published var mtn_momo_acc_name = ""
    @Published var vodafone_momo_number = ""
    @Published var vodafone_momo_acc_name = ""
    @Published var airteltigo_momo_number = ""
    @Published var airteltigo_momo_acc_name = ""

    func checkDetails(user_phone_number: String, password: String) {
        showLoginButton = false
        guard let url = URL(string: "http://144.202.111.61/api/v1/user/login") else { return }

        let body: [String: String] = [
            "user_phone_number": user_phone_number,
            "password": password,
            "user_language": "en",
            "app_type": "ios",
            "app_version_code": FishPottApp.app_version
        ]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSON(data: data)
                if let status = json["status"].string {
                  //Now you got your value
                    print(status)
                    
                    DispatchQueue.main.async {
                        self.requestMade = true
                        if !status.contains("yes") {
                            print(status)
                            self.authenticated = true
                            if let user_phone = json["user_phone"].string {
                                //Now you got your value
                                self.user_phone = user_phone
                                print("user_phone: \(self.user_phone)")
                              }
                            if let user_id = json["user_id"].string {
                                //Now you got your value
                                self.user_id = user_id
                                print("user_id: \(self.user_id)")
                              }
                            if let access_token = json["access_token"].string {
                                //Now you got your value
                                self.access_token = access_token
                                print("access_token: \(self.access_token)")
                              }
                            if let user_pott_name = json["user_pott_name"].string {
                                //Now you got your value
                                self.user_pott_name = user_pott_name
                                print("user_pott_name: \(self.user_pott_name)")
                              }
                            if let user_full_name = json["user_full_name"].string {
                                //Now you got your value
                                self.user_full_name = user_full_name
                                print("user_full_name: \(self.user_full_name)")
                              }
                            if let user_profile_picture = json["user_profile_picture"].string {
                                //Now you got your value
                                self.user_profile_picture = user_profile_picture
                                print("user_profile_picture: \(self.user_profile_picture)")
                              }
                            if let user_country = json["user_country"].string {
                                //Now you got your value
                                self.user_country = user_country
                                print("user_country: \(self.user_country)")
                              }
                            if let user_verified_status = json["user_verified_status"].int {
                                //Now you got your value
                                self.user_verified_status = user_verified_status
                                print("user_verified_status: \(self.user_verified_status)")
                              }
                            if let user_type = json["user_type"].string {
                                //Now you got your value
                                self.user_type = user_type
                                print("user_type: \(self.user_type)")
                              }
                            if let user_gender = json["user_gender"].string {
                                //Now you got your value
                                self.user_gender = user_gender
                                print("user_gender: \(self.user_gender)")
                              }
                            if let user_date_of_birth = json["user_date_of_birth"].string {
                                //Now you got your value
                                self.user_date_of_birth = user_date_of_birth
                                print("user_date_of_birth: \(self.user_date_of_birth)")
                              }
                            if let user_currency = json["user_currency"].string {
                                //Now you got your value
                                self.user_currency = user_currency
                                print("user_currency: \(self.user_currency)")
                              }
                            /*
                             if let id_verification_is_on = json["id_verification_is_on"].bool {
                                //Now you got your value
                                self.id_verification_is_on = id_verification_is_on
                                print("id_verification_is_on: \(self.id_verification_is_on)")
                              }
                             */
                            if let media_allowed = json["media_allowed"].int {
                                //Now you got your value
                                self.media_allowed = media_allowed
                                print("media_allowed: \(self.media_allowed)")
                              }
                            if let user_min_allowed_version = json["user_min_allowed_version"].int {
                                //Now you got your value
                                self.user_min_allowed_version = user_min_allowed_version
                                print("user_min_allowed_version: \(self.user_min_allowed_version)")
                              }
                            if let mtn_momo_number = json["mtn_momo_number"].string {
                                //Now you got your value
                                self.mtn_momo_number = mtn_momo_number
                                print("mtn_momo_number: \(self.mtn_momo_number)")
                              }
                            if let mtn_momo_acc_name = json["mtn_momo_acc_name"].string {
                                //Now you got your value
                                self.mtn_momo_acc_name = mtn_momo_acc_name
                                print("mtn_momo_acc_name: \(self.mtn_momo_acc_name)")
                              }
                            if let vodafone_momo_acc_name = json["vodafone_momo_acc_name"].string {
                                //Now you got your value
                                self.vodafone_momo_acc_name = vodafone_momo_acc_name
                                print("vodafone_momo_acc_name: \(self.vodafone_momo_acc_name)")
                              }
                            if let user_currency = json["airteltigo_momo_acc_name"].string {
                                //Now you got your value
                                self.user_currency = user_currency
                                print("user_currency: \(self.user_currency)")
                              }
                            if let airteltigo_momo_number = json["airteltigo_momo_number"].string {
                                //Now you got your value
                                self.airteltigo_momo_number = airteltigo_momo_number
                                print("airteltigo_momo_number: \(self.airteltigo_momo_number)")
                              }
                            if let airteltigo_momo_acc_name = json["airteltigo_momo_acc_name"].string {
                                //Now you got your value
                                self.airteltigo_momo_acc_name = airteltigo_momo_acc_name
                                print("airteltigo_momo_acc_name: \(self.airteltigo_momo_acc_name)")
                              }
                            
                            
                        } else {
                            self.authenticated = false;
                            self.showLoginButton = true
                            if let message = json["message"].string {
                                //Now you got your value
                                  print(status)
                                  
                                  DispatchQueue.main.async {
                                      self.message = message
                                  }
                              }
                        }
                    }
                }
            } catch  let error as NSError {
                DispatchQueue.main.async {
                    self.requestMade = true
                    self.message = "Login failed"
                    self.authenticated = false
                    self.showLoginButton = true
                }
            }
            
            /*
            let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)
            print(resData)
            if resData.res == "correct" {
                DispatchQueue.main.async {
                    self.authenticated = true
                }
            }
             */
            
        }.resume()
    }
}


class HttpUpdateContentForLogin: ObservableObject {

    @Published var requestMade = false
    @Published var values_set = false
    @Published var showProgress = false

    func update_content() {
        self.showProgress = true
        guard let url = URL(string: "http://144.202.76.74/api/v1/member/guest") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(auth_pass, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print("data")
            print(data)
            do {
                let json = try JSON(data: data)
                if let status = json["status"].int {
                  //Now you got your value
                    print("UPDATED CONTENT")
                    print(status)
                    
                    DispatchQueue.main.async {
                        self.requestMade = true
                        if status == 1 {
                            print(status)
                            
                            if let thisaccesstoken = json["access_token"].string {
                                //Now you got your value
                                saveTextInStorage("user_accesstoken", thisaccesstoken)
                                print("GUEST access_token: \(thisaccesstoken)")
                              }
                            if let firstname = json["user"]["user_firstname"].string {
                                //Now you got your value
                                saveTextInStorage("user_firstname", firstname)
                                print("GUEST userFirstName: \(firstname)")
                              }
                            if let surname = json["user"]["user_surname"].string {
                                //Now you got your value
                                saveTextInStorage("user_lastname", surname)
                                print("GUEST surname: \(surname)")
                              }
                            
                            if let notice_image_one = json["data"]["data"][0]["notice_image"].string {
                                //Now you got your value
                                saveTextInStorage("notice_image_one", notice_image_one)
                                print("note_image_one: \(notice_image_one)")
                              }
                            
                            if let notice_image_two = json["data"]["data"][1]["notice_image"].string {
                                //Now you got your value
                                saveTextInStorage("notice_image_two", notice_image_two)
                                print("notice_image_two: \(notice_image_two)")
                              }
                            
                            if let audio_id = json["audios"]["data"][0]["audio_id"].int {
                                //Now you got your value
                                saveTextInStorage("latest_audio_id", String(audio_id))
                                print("audio_id: \(audio_id)")
                                
                                if let audio_name = json["audios"]["data"][0]["audio_name"].string {
                                    //Now you got your value
                                    saveTextInStorage("latest_audio_name", audio_name)
                                    print("latest_audio_name: \(audio_name)")
                                    if let audio_description = json["audios"]["data"][0]["audio_description"].string {
                                        //Now you got your value
                                        saveTextInStorage("latest_audio_description", audio_description)
                                        print("latest_audio_description: \(audio_description)")
                                        
                                        if let audio_image = json["audios"]["data"][0]["audio_image"].string {
                                            //Now you got your value
                                            saveTextInStorage("latest_audio_image", audio_image)
                                            print("latest_audio_image: \(audio_image)")
                                            if let audio_mp3 = json["audios"]["data"][0]["audio_mp3"].string {
                                                //Now you got your value
                                                saveTextInStorage("latest_audio_mp3", audio_mp3)
                                                print("latest_audio_mp3: \(audio_mp3)")
                                                
                                                if let created_at = json["audios"]["data"][0]["created_at"].string {
                                                    //Now you got your value
                                                    saveTextInStorage("latest_audio_date", created_at)
                                                    print("latest_audio_date: \(created_at)")
                                                  }
                                              }
                                          } //AUDIO IMAGE
                                      }
                                  } // START FOR AUDIO NAME
                              } // END FOR AUDIO ID
                            
                            
                            if let video_id = json["videos"]["data"][0]["video_id"].int {
                                //Now you got your value
                                saveTextInStorage("latest_video1_id", String(video_id))
                                print("latest_video1_id: \(video_id)")
                                
                                if let video_name = json["videos"]["data"][0]["video_name"].string {
                                    //Now you got your value
                                    saveTextInStorage("latest_video1_name", video_name)
                                    print("latest_video1_name: \(video_name)")
                                    
                                    if let video_description = json["videos"]["data"][0]["video_description"].string {
                                        //Now you got your value
                                        saveTextInStorage("latest_video1_description", video_description)
                                        print("latest_video1_description: \(video_description)")
                                        
                                        if let video_image = json["videos"]["data"][0]["video_image"].string {
                                            //Now you got your value
                                            saveTextInStorage("latest_video1_image", video_image)
                                            print("latest_video1_image: \(video_image)")
                                            if let video_mp4 = json["videos"]["data"][0]["video_mp4"].string {
                                                //Now you got your value
                                                saveTextInStorage("latest_video1_mp4", video_mp4)
                                                print("latest_video1_mp4: \(video_mp4)")
                                                
                                                if let created_at = json["videos"]["data"][0]["created_at"].string {
                                                    //Now you got your value
                                                    saveTextInStorage("latest_video1_date", created_at)
                                                    print("latest_video1_date: \(created_at)")
                                                  }
                                              }
                                          } //VIDEO IMAGE
                                      }
                                  } // START FOR VIDEO NAME
                              } // END FOR VIDEO ID
                            
                            if let video_id = json["latest_audios"]["data"][0]["audio_id"].int {
                                //Now you got your value
                                saveTextInStorage("latest_video2_id", String(video_id))
                                print("latest_video2_id: \(video_id)")
                                
                                if let video_name = json["latest_audios"]["data"][0]["audio_name"].string {
                                    //Now you got your value
                                    saveTextInStorage("latest_video2_name", video_name)
                                    print("444 latest_video2_name: \(video_name)")
                                    
                                    if let video_description = json["latest_audios"]["data"][0]["audio_description"].string {
                                        //Now you got your value
                                        saveTextInStorage("latest_video2_description", video_description)
                                        print("latest_video2_description: \(video_description)")
                                        
                                        if let video_image = json["latest_audios"]["data"][0]["audio_image"].string {
                                            //Now you got your value
                                            saveTextInStorage("latest_video2_image", video_image)
                                            print("latest_video2_image: \(video_image)")
                                            if let video_mp4 = json["latest_audios"]["data"][0]["audio_mp3"].string {
                                                //Now you got your value
                                                saveTextInStorage("latest_video2_mp4", video_mp4)
                                                print("latest_video2_mp4: \(video_mp4)")
                                                
                                                if let created_at = json["latest_audios"]["data"][0]["created_at"].string {
                                                    //Now you got your value
                                                    saveTextInStorage("latest_video2_date", created_at)
                                                    print("latest_video2_date: \(created_at)")
                                                    self.values_set = true
                                                    self.showProgress = false
                                                  }
                                              }
                                          } //VIDEO IMAGE
                                      }
                                  } // START FOR VIDEO NAME
                              } // END FOR VIDEO ID
                            
                        }
                    }
                }
            } catch  let error as NSError {
                
                    DispatchQueue.main.async {
                    self.values_set = false
                    self.showProgress = false
                    }
            }
            
        }.resume()
    }
}
