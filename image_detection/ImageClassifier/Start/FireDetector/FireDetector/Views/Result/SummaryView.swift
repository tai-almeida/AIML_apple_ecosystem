//
//  ResultView.swift
//  FireDetector
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct SummaryView: View {
    
    var detectionResult: DetectionResult
    
    var body: some View {
        VStack {
            Spacer()
            
            ResultBadgeView(detection: detectionResult.detection)
            
            VStack {
                Text(label(detectionResult.detection))
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0,
                                        leading: 0,
                                        bottom: 8,
                                        trailing: 0))
                
                Text(confidence(detectionResult))
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
    
    func label(_ type: Detection) -> LocalizedStringResource {
        switch type {
        case .noDetection:
            "NO_DETECTION_LABEL"
        case .fire:
            "FIRE_RESULT_LABEL"
        case .notFire:
            "NOT_FIRE_RESULT_LABEL"
        case .error:
            "BUG_LABEL"
        }
    }
    
    func confidence(_ result: DetectionResult )  -> String {
        switch result.detection {
        case .fire, .notFire:
            String(localized:"CONFIDENCE_LABEL \(formatPercentile(result.confidence) ?? "")")
        case .noDetection:
            String(localized:"NO_DETECTION_CONFIDENCE \(formatPercentile(result.confidence) ?? "")")
        case .error:
            String(localized:"BUG_CONFIDENCE")
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

#Preview {
    SummaryView(detectionResult: DetectionResult(detection: .fire,
                                                 confidence: 0.87))
}
