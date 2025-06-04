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

    var catDogPeople: CatDogPeopleClassifier?
    

    
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
        self.catDogPeople = try? CatDogPeopleClassifier(configuration:
                                                            MLModelConfiguration())

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
        guard let catDogPeople else {
            return
        }

        await MainActor.run {
            processing = true
        }
        do {
            //TODO: Here the model will be called to make a prediction
            let input = CatDogPeopleClassifierInput(livingSituation: housing.rawValue,
                                                    extraversion: extraversion,
                                                    conscientiousness: conciencious,
                                                    socialMediaTime: Double(socialMediaTime),
                                                    photosPet: petPhotos)

            let prediction = try await catDogPeople.prediction(input: input)

            let type = PersonalityType(rawValue: prediction.petType)

            let confidence = prediction.petTypeProbability[prediction.petType]

            if type, confidence {
                await setResult(PersonalityResult(type: type,
                                confidence: confidence))              
            } else {
                await setResult(PersonalityResult(type: .none,
                                                    confidence: 0))  
            }

            try await Task.sleep(for: .seconds(2))
            await setResult(PersonalityResult(type: .dog,
                                              confidence: 0.55))
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
