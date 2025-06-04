//
//  LabeledLikertPicker.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct LabeledLikertPicker: View {
    
    var label: LocalizedStringResource
    var selection: Binding<Int64>
    
    var body: some View {
        LabeledContent {
            LikertPicker(target: selection)
        } label: {
            Text(label)
        }
    }
}

#Preview {
    @Previewable @State var likertResult: Int64 = 0
    
    LabeledLikertPicker(label: "How much do you agree with this question?",
                        selection: $likertResult)
}
