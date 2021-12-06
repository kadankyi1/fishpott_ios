//
//  SuggestionView.swift
//  FishPott
//
//  Created by Dankyi Anno Kwaku on 12/2/21.
//

import SwiftUI

struct SuggestionView: View {
    // MARK: - PROPERTIES
    @State private var shouldRefresh = false
    
    
    var body: some View {
        DrillQuestionView()
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionView()
    }
}

