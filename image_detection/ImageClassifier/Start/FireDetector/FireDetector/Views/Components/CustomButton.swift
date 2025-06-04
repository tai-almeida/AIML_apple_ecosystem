//
//  CustomButton.swift
//  FireDetector
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct CustomButton: View {
    
    var title: LocalizedStringResource
    var action: () -> Void
    
    var body: some View {
        Button {
           action()
        } label: {
            Text(title)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity)
        }
        .labelStyle(.titleOnly)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .tint(.button)
    }
}

#Preview {
    CustomButton(title: "Teste") {
        print("click!")
    }
}
