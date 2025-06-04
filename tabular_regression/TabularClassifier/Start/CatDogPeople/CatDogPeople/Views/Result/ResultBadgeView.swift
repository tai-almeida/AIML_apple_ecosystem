//
//  ResultBadgeView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct ResultBadgeView: View {
    
    let gradient = Gradient(colors: [Color("Gradient-Start"),
                                     Color("Gradient-Medium"),
                                     Color("Gradient-End")])
    
    
    var personality: PersonalityResult
    
    var body: some View {
        Image(systemName: icon(personality.type))
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding(20)
            .background {
                Circle()
                    .fill( LinearGradient(
                        gradient: gradient,
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ))
            }
    }
    
    func icon(_ type: PersonalityType) -> String {
        switch type {
        case .none:
            "questionmark"
        case .cat:
            "cat.fill"
        case .dog:
            "dog.fill"
        }
    }
}

#Preview {
    ResultBadgeView(personality: PersonalityResult(type: .dog,
                                                   confidence: 0.40))
}

#Preview {
    ResultBadgeView(personality: PersonalityResult(type: .cat,
                                                   confidence: 0.90))
}

#Preview {
    ResultBadgeView(personality: PersonalityResult(type: .none,
                                                   confidence: 0.90))
}
