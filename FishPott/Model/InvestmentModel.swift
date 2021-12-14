//
//  IntroModel.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/20/21.
//

import SwiftUI


// MARK: - INVESTMENT DATA MODEL
struct InvestmentModel: Identifiable {
    var id = UUID()
    var business_id: String
    var cost_per_share_usd: String
    var value_per_share_usd: String
    var quantity_of_stocks: String
    var value_phrase: String
    var ai_info: String
}
