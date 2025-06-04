//
//  ResultView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 11/11/24.
//

import SwiftUI

struct ResultView: View {
    
    @Environment(Navigation.self) var navigation
    @Environment(QuestionnarieData.self) var data
    
    var body: some View {
        VStack {
            if !data.processing {
                SummaryView(personalityResult: data.personalityResult)
            } else {
                ProcessingState()
            }
            CustomButton(title: "RESTART_BUTTON_LABEL") {
                data.clear()
                navigation.path = []
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Dog Person") {
    
    @Previewable @State var navigation = Navigation()
    @Previewable @State var data = QuestionnarieData(personalityResult: PersonalityResult(type: .dog, confidence: 0.05))
    
    NavigationStack(path: $navigation.path) {
        ResultView()
    }
    .environment(navigation)
    .environment(data)
}

#Preview("Cat Person") {
    
    @Previewable @State var navigation = Navigation()
    @Previewable @State var data = QuestionnarieData(personalityResult: PersonalityResult(type: .cat, confidence: 0.75))
    
    NavigationStack(path: $navigation.path) {
        ResultView()
    }
    .environment(navigation)
    .environment(data)
}

#Preview("Full Cat Person") {
    
    @Previewable @State var navigation = Navigation()
    @Previewable @State var data = QuestionnarieData(personalityResult: PersonalityResult(type: .cat, confidence: 1.00))
    
    NavigationStack(path: $navigation.path) {
        ResultView()
    }
    .environment(navigation)
    .environment(data)
}

#Preview("None") {
    
    @Previewable @State var navigation = Navigation()
    @Previewable @State var data = QuestionnarieData(personalityResult: PersonalityResult(type: .none, confidence: 0))
    
    NavigationStack(path: $navigation.path) {
        ResultView()
        
    }
    .environment(navigation)
    .environment(data)
}

#Preview("Processing") {
    
    @Previewable @State var navigation = Navigation()
    @Previewable @State var data = QuestionnarieData(
        processing: true,
        personalityResult: PersonalityResult(type: .none,
                                             confidence: 0))
    
    NavigationStack(path:$navigation.path) {
        ResultView()
    }
    .environment(navigation)
    .environment(data)
}
