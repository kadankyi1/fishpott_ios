//
//  MainView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/1/21.
//


import SwiftUI
import SwiftyJSON

struct MainView: View {
    @Binding var currentStage: String
    
    init(currentStage: Binding<String>) {
        self._currentStage = .constant("MainView")
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
        
        for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }
    
    //var access_token: String = getSavedString("user_accesstoken");
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    @State var now = Date()
    
    let tabBarImageNames = ["suggestions", "finder", "investments", "profile", ]
    let tabBarMenuNames = ["Suggestions", "Finder", "Investments", "Profile"]
    
    var body: some View {
        /*
        var timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
            (_) in
            updateContent.update_content(user_accesstoken: getSavedString("user_accesstoken"));
        }
         */
        VStack(spacing: 0) {
            
        Text("FishPott ")
            .foregroundColor(Color(.white))
            .font(.custom("SweetSensationsPersonalUse", size: 30))
            .padding(.top, 5)
            
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        Button(action: {shouldShowModal.toggle()}, label: {
                            Text("Fullscreen cover")
                        })
                    
                })
                
                switch selectedIndex {
                case 0:
                    /*
                     NavigationView {
                        ScrollView {
                            ForEach(0..<100) { num in
                                Text("\(num)")
                            }
                        }
                        .navigationTitle("Today Page")
                    }*/
                    SuggestionView()
                case 1:
                    InvestmentsView()
                case 2:
                    /*
                    ScrollView {
                        Text("Read Page")
                    }
                    */
                    FinderView()
                    
                case 3:
                    ProfileView()
                    
                default:
                    NavigationView {
                        Text("Remaining tabs")
                        
                    }
                }
                
            }
            
//            Spacer()
            
            Divider()
                .padding(.bottom, 8)
                .background(Color.white)
            
            HStack {
                ForEach(0..<4) { num in
                    Button(action: {
                        
                        /*
                        if num == 2 {
                            shouldShowModal.toggle()
                            return
                        }
                        */
                        
                        selectedIndex = num
                        
                    }, label: {
                        Spacer()
                        
                        VStack {
                                 Image(tabBarImageNames[num])
                                    .renderingMode(.template)
                                    .colorMultiply(.init(white: 0.8))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                                Text(tabBarMenuNames[num])
                                    .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                                    .font(.system(size: 12))
                            Spacer()
                        } // MARK: - VSTACK
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 55)
                    })
                    
                }
            } // MARK: - HSTACK
            
            .background(Color.white)
            
            
        }
        .background(Color.black)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(currentStage: .constant("MainView"))
    }
}

