//
//  FireDetector.swift
//  FireDetector
//
//  Created by Sergio Ordine on 18/11/24.
//

import SwiftUI

@Observable
class FireDetector {
    
    let desiredConfidence = 0.8
    var processing:Bool = false
    var result: DetectionResult = DetectionResult(detection: .noDetection,
                                                  confidence: 0)
    
    var fireDetectorModel: FireImageClassifier?
    
    init() {
        fireDetectorModel = try? FireImageClassifier()
    }
    
    func clear() {
        processing = false
        result = DetectionResult(detection: .noDetection,
                                 confidence: 0)
    }
    
    func detect(image:UIImage) async {
        
        guard let fireDetectorModel else {
            return
        }
        
        await MainActor.run {
            processing = true
        }
        
        if let cgImage = image.cgImage {
            do {
                let input = try FireImageClassifierInput(imageWith: cgImage)
                let prediction = try await fireDetectorModel.prediction(input: input)
                
                let confidence = prediction.targetProbability[prediction.target] ?? 0.0
                
                if confidence > desiredConfidence {
                    let detection: Detection =  Detection(rawValue: prediction.target) ?? .noDetection
                    await setResult(DetectionResult(detection: detection,
                                                    confidence: confidence))
                } else {
                    await setResult(DetectionResult(detection: .noDetection,
                                                    confidence: confidence ))
                }
                
            } catch {
                await setResult(DetectionResult(detection: .error,
                                                confidence: 0))
            }
        } else {
            await setResult(DetectionResult(detection: .error,
                                            confidence: 0))
        }
    }
    
    func setResult(_ detectionResult: DetectionResult) async {
        await MainActor.run {
            result = detectionResult
            processing = false
        }
    }
}
