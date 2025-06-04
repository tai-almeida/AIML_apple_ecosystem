//
//  ResultBadgeView.swift
//  FireDetector
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct ResultBadgeView: View {
    
    var detection: Detection
    
    var body: some View {
        Image(systemName: icon(detection))
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding(20)
            .background {
                Circle()
                    .fill(color(detection))
            }
    }
    
    func icon(_ type: Detection) -> String {
        switch type {
        case .noDetection:
            "questionmark"
        case .fire:
            "fire.extinguisher.fill"
        case .notFire:
            "drop.fill"
        case .error:
            "ladybug.fill"
        }
    }
    
    func color(_ type: Detection) -> Color {
        switch type {
        case .fire:
            .fire
        case .notFire:
            .notFire
        case .noDetection:
            .gray
        case .error:
            .fire
        }
    }
}

#Preview("Fire!") {
    ResultBadgeView(detection:.fire)
}

#Preview("Not a Fire") {
    ResultBadgeView(detection:.notFire)
}

#Preview("No Result") {
    ResultBadgeView(detection:.noDetection)
}

#Preview("Bug") {
    ResultBadgeView(detection:.error)
}
