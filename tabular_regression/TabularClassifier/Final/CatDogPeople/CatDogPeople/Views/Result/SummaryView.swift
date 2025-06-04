//
//  SummaryView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct SummaryView: View {
    
    var personalityResult: PersonalityResult
    
    var body: some View {
        VStack {
            Spacer()
            ResultBadgeView(personality: personalityResult)
            VStack {
                Text(label(personalityResult.type))
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0,
                                        leading: 0,
                                        bottom: 8,
                                        trailing: 0))
                Text(confidence(personalityResult))
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
    
    func label(_ type: PersonalityType) -> LocalizedStringResource {
        switch type {
        case .none:
            "NO_RESULT_LABEL"
        case .cat:
            "CAT_RESULT_LABEL"
        case .dog:
            "DOG_RESULT_LABEL"
        }
    }
    
    func confidence(_ result: PersonalityResult )  -> String {
        switch result.type {
        case .none:
            String(localized:"NO_RESULT_CONFIDENCE")
        case .cat,.dog:
            String(localized:"CONFIDENCE_LABEL \(formatPercentile(personalityResult.confidence ?? 0.0) ?? "")")
        }
    }
    
    func formatPercentile(_ percentage: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.minimumIntegerDigits = 1
        
        let value = NSNumber(value: percentage * 100)
        return formatter.string(from: value)
    }
}

#Preview("Dog Person") {
    SummaryView(personalityResult: PersonalityResult(type: .dog,
                                                     confidence: 0.75))
}

#Preview("Cat Person") {
    SummaryView(personalityResult: PersonalityResult(type: .cat,
                                                     confidence: 0.05))
}

#Preview("Full Cat Person") {
    SummaryView(personalityResult: PersonalityResult(type: .cat,
                                                     confidence: 1.0))
}

#Preview("None") {
    SummaryView(personalityResult: PersonalityResult(type: .none,
                                                     confidence: 0))
}
