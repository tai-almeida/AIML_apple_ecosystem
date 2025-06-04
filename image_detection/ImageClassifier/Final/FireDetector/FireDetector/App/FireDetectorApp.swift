//
//  FireDetectorApp.swift
//  FireDetector
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

@main
struct FireDetectorApp: App {
    
    @State var navigation = Navigation()
    @State var detector = FireDetector()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.path) {
                StartView()
                    .navigationDestination(for: Scenes.self) { scene in
                        switch scene {
                        case .startScreen: StartView()
                        case .prediction: ResultView()
                        }
                    }
            }
        }
        .environment(navigation)
        .environment(detector)
    }
}
