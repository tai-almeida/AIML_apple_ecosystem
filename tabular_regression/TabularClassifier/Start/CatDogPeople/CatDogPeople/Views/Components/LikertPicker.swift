//
//  LikertView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 12/11/24.
//

import SwiftUI

struct LikertPicker: View {
    
    @Binding var target: Int64
    
    var body: some View {
        Picker("", selection: $target) {
            Text("STRONGLY_DISAGREE")
                .tag(Int64(0))
            Text("DISAGREE")
                .tag(Int64(1))
            Text("NO_OPINION")
                .tag(Int64(2))
            Text("AGREE")
                .tag(Int64(3))
            Text("STRONGLY_AGREE")
                .tag(Int64(4))
        }
    }
}

#Preview {
    @Previewable @State var value: Int64 = 0
    LikertPicker(target: $value)
}
