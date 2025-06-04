//
//  ContentView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 11/11/24.
//

import SwiftUI

struct QuestionnarieFormView: View {
    
    @Environment(QuestionnarieData.self) var data
    
    var body: some View {
        Form {
            @Bindable var questionnarieData = data
            
            LabeledContent {
                Picker("", selection: $questionnarieData.housing) {
                    Text("HOUSE")
                        .tag(Housing.house)
                    Text("APARTMENT")
                        .tag(Housing.apartment)
                }
            } label: {
                Text("LIVE_SITUATION_LABEL")
            }
            
            LabeledTimePicker(label: "SOCIAL_MEDIA_LABEL",
                              selection: $questionnarieData.socialMediaTime,
                              elements: TimeRanges.mediaTime)
            
            LabeledTimePicker(label: "PET_PHOTOS_LABEL",
                              selection: $questionnarieData.petPhotos,
                              elements: TimeRanges.petPhotosElement)
            
            LabeledLikertPicker(label: "EXTRAVERSION_QUESTION_LABEL",
                                selection: $questionnarieData.extraversion)
            
            LabeledLikertPicker(label: "CONCIENCIOUS_QUESTION_LABEL",
                                selection: $questionnarieData.conciencious)
        }
    }
}

#Preview {
    @Previewable @State var data = QuestionnarieData(personalityResult: PersonalityResult(type: .none, confidence: 0))
    
    QuestionnarieFormView()
        .environment(data)
}
