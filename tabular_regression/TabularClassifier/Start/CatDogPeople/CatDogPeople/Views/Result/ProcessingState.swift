//
//  EmptyState.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

struct ProcessingState: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "brain")
                .foregroundColor(.icon)
                .font(.largeTitle)
                .scaleEffect(CGSize(width: 2.0,
                                    height: 2.0))
                .padding()
            Text("WAITING_LABEL")
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundStyle(.secondary)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    ProcessingState()
}
