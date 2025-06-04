//
//  CatDogPeopleApp.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 11/11/24.
//

import SwiftUI

@main
struct CatDogPeopleApp: App {
    
    @State var navigation = Navigation()
    @State var data = QuestionnarieData(personalityResult: PersonalityResult(type: .none,
                                                                             confidence: 0))
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.path) {
                StartView()
                    .navigationDestination(for: Scenes.self) { scene in
                        switch scene {
                        case .startScreen: StartView()
                        case .questionnarie: QuestionnarieView()
                        case .prediction: ResultView()
                        }
                    }
            }
        }
        .environment(navigation)
        .environment(data)
    }
}
