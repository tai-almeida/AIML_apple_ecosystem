//
//  TimeRangedElement.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 18/11/24.
//

import Foundation

struct TimeRangedElement: Identifiable {
    var id: String {
        String(localized: name)
    }
    
    var name: LocalizedStringResource
    var value: Int64
}
