//
//  IntroModel.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/20/21.
//

import SwiftUI


// MARK: - INVESTMENT DATA MODEL
struct TransactionModel: Identifiable {
    var id = UUID()
    var type: String
    var status: String
    var info_1: String
    var info_2: String
    var info_3: String
    var info_4: String
    var info_5: String
    var info_6: String
}
