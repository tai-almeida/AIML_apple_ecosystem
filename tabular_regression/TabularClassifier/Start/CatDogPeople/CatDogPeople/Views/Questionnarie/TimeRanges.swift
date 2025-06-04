//
//  TimeRangedElements.swift
//  CatDogPeople
//
//  Created by Sergio Ordine on 18/11/24.
//

import Foundation

struct TimeRanges {
    static var mediaTime:[TimeRangedElement] = [
        TimeRangedElement(name:"NO_MEDIA_TIME", value:0),
        TimeRangedElement(name:"MEDIA_STEP_1", value:5),
        TimeRangedElement(name:"MEDIA_STEP_2", value:15),
        TimeRangedElement(name:"MEDIA_STEP_3", value:25),
        TimeRangedElement(name:"MEDIA_STEP_4", value:35),
        TimeRangedElement(name:"MEDIA_STEP_5", value:45)
    ]
    
    static var petPhotosElement:[TimeRangedElement] = [
        TimeRangedElement(name:"NO_PHOTOS", value:0),
        TimeRangedElement(name:"PHOTO_STEP_1", value:5),
        TimeRangedElement(name:"PHOTO_STEP_2", value:20),
        TimeRangedElement(name:"PHOTO_STEP_3", value:40),
        TimeRangedElement(name:"PHOTO_STEP_4", value:60),
        TimeRangedElement(name:"PHOTO_STEP_5", value:85)
    ]
}
