//
//  InvestmentData.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/14/21.
//

import SwiftUI

// MARK: - INTRO DATA

let investmentData: [InvestmentModel] = [
    InvestmentModel(
        stock_id: "so-bizid1",
        business_id: "bizid1",
        business_name: "Randy Pharmacy",
        cost_per_share_usd: "$1",
        buyback_usd: "$0.5",
        total_value: "$500",
        value_per_share_usd: "$3",
        quantity_of_stocks: "100",
        value_phrase: "Value Profit",
        ai_info: "Your networth is up"
    ),
    InvestmentModel(
        stock_id: "so-bizid1",
        business_id: "bizid1",
        business_name: "Break Cafe",
        cost_per_share_usd: "$4",
        buyback_usd: "$0.5",
        total_value: "$500",
        value_per_share_usd: "$2",
        quantity_of_stocks: "500",
        value_phrase: "Value Loss",
        ai_info: "Your networth has reduced"
    ),
    InvestmentModel(
        stock_id: "so-bizid1",
        business_id: "bizid1",
        business_name: "Break Cafe",
        cost_per_share_usd: "$4",
        buyback_usd: "$0.5",
        total_value: "$500",
        value_per_share_usd: "$4",
        quantity_of_stocks: "500",
        value_phrase: "Value Neutral",
        ai_info: "Your networth stays neutral"
    )
]
