//
//  CellInfoView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 12/11/24.
//

import SwiftUI

struct InfoCell: View {
    
    var icon: String
    var title: LocalizedStringResource
    var text: LocalizedStringResource
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: icon)
                .foregroundColor(.icon)
                .font(.largeTitle)
                .padding(.trailing, 16) 
            VStack(alignment: .leading) {
                Text(title)
                Text(text)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 0)
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .background(.clear)
        .cornerRadius(10)
    }
}

#Preview {
    InfoCell(icon: "tortoise",
             title: "Tortoise Person",
             text: "A tortoise person in a nice and peaceful person.")
    .padding()
}
