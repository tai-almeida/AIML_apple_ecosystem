//
//  ResultVire.swift
//  FireDetector
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct ResultView: View {
    
    @Environment(Navigation.self) var navigation
    @Environment(FireDetector.self) var detector
    
    var body: some View {
        VStack {
            if !detector.processing {
                VStack {
                    SummaryView(detectionResult: detector.result)
                }
                .padding()
                .navigationBarBackButtonHidden(true)
            } else {
                ProcessingState()
            }
            
            Button("TEST_AGAIN_LABEL") {
                navigation.path = []
            }
            .foregroundStyle(.button)
            .font(.footnote)
            .fontWeight(.bold)
            
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var navigation = Navigation()
    @Previewable @State var detector = FireDetector()
    
    NavigationStack(path:$navigation.path) {
        ResultView()
    }
    .environment(navigation)
    .environment(detector)
}
