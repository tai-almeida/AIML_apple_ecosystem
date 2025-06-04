//
//  CustomButton.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 12/11/24.
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
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
        }
        .labelStyle(.titleOnly)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .tint(Color("ButtonColor"))
    }
}

#Preview {
    CustomButton(title: "Teste") {
        print("click!")
    }
}
