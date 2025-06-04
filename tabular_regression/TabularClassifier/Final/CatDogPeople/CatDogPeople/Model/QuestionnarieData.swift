//
//  File.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 12/11/24.
//

import SwiftUI
import CoreML

@Observable
class QuestionnarieData {
    
    var housing: Housing = .house
    var extraversion: Int64 = 0
    var conciencious: Int64 = 0
    var socialMediaTime: Int64 = 0
    var petPhotos: Int64 = 0
    
    var catDogPerson: CatDogPersonClassifier?
    
    var processing: Bool = false
    var personalityResult: PersonalityResult
    
    init(housing: Housing = .house,
         extraversion: Int64 = 0,
         conciencious: Int64 = 0,
         socialMediaTime: Int64 = 0,
         petPhotos: Int64 = 0,
         processing: Bool = false,
         personalityResult: PersonalityResult) {
        
        self.housing = housing
        self.extraversion = extraversion
        self.conciencious = conciencious
        self.socialMediaTime = socialMediaTime
        self.petPhotos = petPhotos
        self.processing = processing
        self.personalityResult = personalityResult
        self.catDogPerson = try? CatDogPersonClassifier(configuration: MLModelConfiguration())
    }
    
    func clear() {
        housing = .house
        extraversion = 0
        conciencious = 0
        socialMediaTime = 0
        petPhotos = 0
        processing = false
        personalityResult = PersonalityResult(type: .none,
                                              confidence: 0)
    }
    
    func predict() async {
        
        guard let catDogPerson  else {
            return
        }
        
        await MainActor.run {
            processing = true
        }
        
        do {
            let input = CatDogPersonClassifierInput(conscientiousness: conciencious,
                                                    extraversion: extraversion,
                                                    livingSituation: housing.rawValue,
                                                    photosPet: petPhotos,
                                                    socialMediaTime: Double(socialMediaTime))
            
            let prediction = try await catDogPerson.prediction(input: input)
            
            let type = PersonalityType(rawValue: prediction.petType)
            let probability = prediction.petTypeProbability[prediction.petType]
            
            if let type,
               let probability {
                await setResult(PersonalityResult(type: type,
                                                  confidence: probability))
            } else {
                await setResult(PersonalityResult(type: .none,
                                                  confidence: 0))
            }
            
        } catch {
            await setResult(PersonalityResult(type: .none,
                                              confidence: 0))
        }
    }
    
    func setResult(_ personalityResult: PersonalityResult) async {
        await MainActor.run {
            self.personalityResult = personalityResult
            self.processing = false
        }
    }
}
