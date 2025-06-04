//
//  LabeledTImePicker.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct LabeledTimePicker: View {
    
    var label: LocalizedStringResource
    var selection: Binding<Int64>
    var elements: [TimeRangedElement]
    
    var body: some View {
        LabeledContent {
            Picker("", selection: selection) {
                ForEach(elements) { element in
                    Text(element.name)
                        .tag(element.value)
                }
            }
        } label: {
            Text(label)
        }
    }
}

#Preview {
    @Previewable @State var workTime: Int64 = 0
    
    LabeledTimePicker(label: "Time of work (per week)",
                      selection: $workTime,
                      elements: TimeRanges.mediaTime)
}
