//
//  QuestionnarieView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 12/11/24.
//

import SwiftUI

struct QuestionnarieView: View {
    
    @Environment(Navigation.self) var navigation
    @Environment(QuestionnarieData.self) var data
    
    var body: some View {
        VStack {
            QuestionnarieFormView()
            CustomButton(title: "CONTINUE_BUTTON_LABEL") {
                Task {
                    await data.predict()
                }
                navigation
                    .path
                    .append(.prediction)
                
            }
            .padding()
            
        }
        .background(.background.secondary)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @Previewable @State var navigation = Navigation()
    @Previewable @State var data = QuestionnarieData(personalityResult: PersonalityResult(type: .none, confidence: 0))
    
    NavigationStack(path:$navigation.path) {
        QuestionnarieView()
    }
    .environment(navigation)
    .environment(data)
}
