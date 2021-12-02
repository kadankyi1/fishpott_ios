//
//  SignupView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/20/21.
//

import SwiftUI
import SwiftyJSON

struct SignupView: View {
    
    @State private var user_firstname: String = ""
    @State private var user_surname: String = ""
    @State private var user_country: String = ""
    @State private var user_gender: String = ""
    @State private var user_dob: String = ""
    @State private var user_pottname: String = ""
    @State private var user_email: String = ""
    @State private var user_phone_number: String = ""
    @State private var password: String = ""
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State private var networking: Bool = false
    
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager = SignupHttpAuth()
    @Binding var currentStage: String
    
    @State private var lastSelectedIndex: Int?
    
    @State var countries = ["Ghana","United Kingdom","USA","Afghanistan","Albania","Algeria","American Samoa","Andorra","Angola","Anguilla","Antarctica","Antigua and Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Bouvet Island","Brazil","British Indian Ocean Territory","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos (Keeling) Islands","Colombia","Comoros","Congo","Cook Islands","Costa Rica","Cote d\'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Democratic Republic of the Congo","Denmark","Djibouti","Dominica","Dominican Republic","East Timor","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Faeroe Islands","Falkland Islands","Fiji","Finland","Former Yugoslav Republic of Macedonia","France","French Guiana","French Polynesia","French Southern Territories","Gabon","Georgia","Germany","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Heard Island and McDonald Islands","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Niue","Norfolk Island","North Korea","Northern Marianas","Norway","Oman","Pakistan","Palau","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn Islands","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Sao Tome and Principe","Saint Helena","Saint Kitts and Nevis","Saint Lucia","Saint Pierre and Miquelon","Saint Vincent and the Grenadines","Samoa","San Marino","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia and the South Sandwich Islands","South Korea","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Svalbard and Jan Mayen","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","The Bahamas","The Gambia","Togo","Tokelau","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Turks and Caicos Islands","Tuvalu","Virgin Islands","Uganda","Ukraine","United Arab Emirates","United States Minor Outlying Islands","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Wallis and Futuna","Western Sahara","Yemen","Yugoslavia","Zambia","Zimbabwe"] //Here Add Your data
    @State var countryIndex = 0
    
    
    @State private var lastSelectedGender: Int?
    
    @State var genders = ["Male","Female"] //Here Add Your data
    @State var genderIndex = 0
        
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
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
                    Text("Signup Successful")
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
            }
 
            HStack{
                
                TextField("First Name", text: $user_firstname).textFieldStyle(RoundedBorderTextFieldStyle.init())
                    .scaleEffect(x: 1, y: 1, anchor: .center)
                
                TextField("Last Name", text: $user_surname).textFieldStyle(RoundedBorderTextFieldStyle.init())
                    .scaleEffect(x: 1, y: 1, anchor: .center)
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 50)
            
            
           HStack{
               PickerTextField(data: ["Ghana","United Kingdom","USA","Afghanistan","Albania","Algeria","American Samoa","Andorra","Angola","Anguilla","Antarctica","Antigua and Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Bouvet Island","Brazil","British Indian Ocean Territory","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos (Keeling) Islands","Colombia","Comoros","Congo","Cook Islands","Costa Rica","Cote d\'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Democratic Republic of the Congo","Denmark","Djibouti","Dominica","Dominican Republic","East Timor","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Faeroe Islands","Falkland Islands","Fiji","Finland","Former Yugoslav Republic of Macedonia","France","French Guiana","French Polynesia","French Southern Territories","Gabon","Georgia","Germany","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Heard Island and McDonald Islands","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Niue","Norfolk Island","North Korea","Northern Marianas","Norway","Oman","Pakistan","Palau","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn Islands","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Sao Tome and Principe","Saint Helena","Saint Kitts and Nevis","Saint Lucia","Saint Pierre and Miquelon","Saint Vincent and the Grenadines","Samoa","San Marino","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia and the South Sandwich Islands","South Korea","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Svalbard and Jan Mayen","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","The Bahamas","The Gambia","Togo","Tokelau","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Turks and Caicos Islands","Tuvalu","Virgin Islands","Uganda","Ukraine","United Arab Emirates","United States Minor Outlying Islands","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Wallis and Futuna","Western Sahara","Yemen","Yugoslavia","Zambia","Zimbabwe"],placeholder: "Select Country",lastSelectedIndex: self.$lastSelectedIndex)
                   .frame(height: 10, alignment: .bottom)
                   .scaleEffect(x: 1, y: 1, anchor: .center)
               PickerTextField(data: ["Male","Female"],placeholder: "Choose Gender",lastSelectedIndex: self.$lastSelectedGender)
                   .frame(height: 10, alignment: .bottom)
                   .scaleEffect(x: 1, y: 1, anchor: .center)
           }
           .padding(.horizontal, 50)
           //.padding(.vertical, 100)
           .padding(.bottom, -100)
           .padding(.top, -25)
            
            HStack{
                //C86311D47
            TextField("Pottname", text: $user_pottname).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
            
            TextField("Date Of Birth", text: $user_dob).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
            
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 10)
            
        
            TextField("Email", text: $user_email).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            TextField("Phone", text: $user_phone_number).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .top)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            if manager.showLoginButton {
                Button(action: {
                    
                    user_country = countries[lastSelectedIndex ?? 0]
                    user_gender = genders[lastSelectedGender ?? 0]
                    print("user_firstname: \(self.user_firstname)")
                    print("user_surname: \(self.user_surname)")
                    print("user_country: \(self.user_country)")
                    print("user_gender: \(self.user_gender)")
                    //print("$lastSelectedIndex country: \(countries[lastSelectedIndex ?? 0])")
                    print("user_dob: \(self.user_dob)")
                    print("user_pottname: \(self.user_pottname)")
                    print("user_email: \(self.user_email)")
                    print("user_phone_number: \(self.user_phone_number)")
                    print("password: \(self.password)")
                    //print("repeat_password: \(self.repeat_password)")
                    if networking == false {
                        networking = true;
                        manager.checkDetails(user_firstname: self.user_firstname, user_surname: self.user_surname, user_country: self.user_country, user_gender: self.user_gender, user_dob: self.user_dob, user_pottname: self.user_pottname, user_email: self.user_email, user_phone_number: self.user_phone_number, password: self.password, app_version: FishPottApp.app_version)
                    }
                }) {
                    HStack (spacing: 8) {
                        Text("SIGN UP")
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
                
            } else {
                ProgressView()
            }
            
            SignupActionTextsViews(currentStage: $currentStage)
                //.padding(.vertical, 35)
            
        }
        .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
    }
}

func saveTextInStorage(_ index: String, _ value: String) {
    UserDefaults.standard.set(value, forKey:index)
}

func saveIntegerInStorage(_ index: String, _ value: Int) {
    UserDefaults.standard.set(value, forKey:index)
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(currentStage: .constant("LoginView"))
    }
}


class SignupHttpAuth: ObservableObject {

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

    func checkDetails(
        user_firstname: String,
        user_surname: String,
        user_country: String,
        user_gender: String,
        user_dob: String,
        user_pottname: String,
        user_email: String,
        user_phone_number: String,
        password: String,
        app_version: String) {
        showLoginButton = false
        guard let url = URL(string: "http://144.202.111.61/api/v1/user/register-personal") else { return }

        let body: [String: String] =
            [
                "user_firstname": user_firstname,
                "user_surname": user_surname,
                "user_gender": user_gender,
                "user_country": user_country,
                "user_dob": user_dob,
                "user_pottname": user_pottname,
                "user_email": user_email,
                "user_phone_number": user_phone_number,
                "password": password,
                "user_referred_by": "",
                "user_language": "en",
                "app_type": "ios",
                "app_version_code": app_version
            ]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("text/json", forHTTPHeaderField: "Accept")

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
                        if status == "yes" {
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
                print((error as NSError).localizedDescription)
                DispatchQueue.main.async {
                    self.requestMade = true
                    self.message = "Registration failed"
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
