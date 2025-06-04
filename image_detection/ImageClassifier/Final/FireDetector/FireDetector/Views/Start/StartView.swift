//
//  ContentView.swift
//  FireDetector
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI
import PhotosUI

struct StartView: View {
    
    @Environment(Navigation.self) var navigation
    @Environment(FireDetector.self) var detector
    
    @State private var presentPhotoPicker: Bool = false
    @State private var fireItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            VStack {
                Image(.titleBadge)
                    .padding()
                
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
                
                Spacer()
            }
            VStack(alignment: .center) {
                Text(String(localized:"PRIVACY_DISCLAIMER"))
                    .multilineTextAlignment(.center)
                    .font(.caption2)
                    .listRowBackground(Color.clear)
                    .foregroundStyle(.secondary)
                
                CustomButton(title:"SELECT_BUTTON_LABEL") {
                    presentPhotoPicker = true
                }
            }
        }
        .padding()
        .background(.background.secondary)
        .photosPicker(isPresented: $presentPhotoPicker,
                      selection: $fireItem)
        .onChange(of: fireItem) {
            Task {
                if let loaded = try? await fireItem?.loadTransferable(type: Data.self),
                   let fireImage = UIImage(data: loaded) {
                    Task {
                        await detector.detect(image: fireImage)
                    }
                    navigation.path.append(.prediction)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var navigation = Navigation()
    @Previewable @State var detector = FireDetector()
    
    NavigationStack(path:$navigation.path) {
        StartView()
    }
    .environment(navigation)
    .environment(detector)
}
