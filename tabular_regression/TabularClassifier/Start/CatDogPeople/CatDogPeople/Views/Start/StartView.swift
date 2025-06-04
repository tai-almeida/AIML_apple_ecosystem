//
//  StartView.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 12/11/24.
//

import SwiftUI

struct StartView: View {
    
    @Environment(Navigation.self) var navigation
    
    var body: some View {
        VStack {
            List {
                Section {
                    VStack  {
                        Image(.titleBadge)
                        Text("APP_NAME")
                            .fixedSize(horizontal: false,
                                       vertical: true)
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        Text("APP_DESCRIPTION")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .listRowBackground(Color.clear)
                }
                Section {
                    InfoCell(icon: "cat.fill",
                             title: "CAT_PERSON_LABEL",
                             text: "CAT_PERSON_DESCRIPTION")
                    .listRowSeparator(.hidden)
                    
                    InfoCell(icon: "dog.fill",
                             title: "DOG_PERSON_LABEL",
                             text: "DOG_PERSON_DESCRIPTION")
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            VStack(alignment: .center) {
                Text(String(localized:"PRIVACY_DISCLAIMER"))
                    .multilineTextAlignment(.center)
                    .font(.caption2)
                    .listRowBackground(Color.clear)
                    .foregroundStyle(.secondary)
                
                CustomButton(title:"DISCOVER_BUTTON_LABEL") {
                    navigation.path.append(.questionnarie)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .padding()
        }
        .background(.background.secondary)
    }
}

#Preview {
    @Previewable @State var navigation = Navigation()
    
    NavigationStack(path: $navigation.path) {
        StartView()
    }
    .environment(navigation)
}
