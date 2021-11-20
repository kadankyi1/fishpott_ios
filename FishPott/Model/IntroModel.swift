//
//  IntroModel.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 11/20/21.
//

import SwiftUI


// MARK: - INTRO DATA MODEL

struct IntroModel: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradidentColors: [Color]
    var description: String
}
