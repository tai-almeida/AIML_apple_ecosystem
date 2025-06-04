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
    var FireDetectorModel: FireImageClassifier?
    
    
    init() {
        FireDetectorModel = try? FireImageClassifier()
    }
    
    func clear() {
        processing = false
        result = DetectionResult(detection: .noDetection,
                                 confidence: 0)
    }
    
    func detect(image:UIImage) async {
        
        await MainActor.run {
            processing = true
        }
        
        guard let cgImage = image.cgImage else {
            await setResult(DetectionResult(detection: .error,
                                            confidence: 0))
            return
        }
  
        do {
            //TODO: Here will come the code for the ML model prediction
            let input = try FireImageClassifierInput(imageWith: cgImage) // create input with a cg Image

            let prediction = try await fireDetectorModel.prediction(input: input)

            let confidence = prediction.targetProbability[prediction.target] ?? 0.0

            if confidence > desiredConfidence {
                let detection: Detection = Detection(rawValue: prediction.target)

                await setResult(DetectionResult(detection: detection,
                                                confidence:confidence))
            } else {
                await setResult(DetectionResult(detection: .noDetection,
                                confidence: confidence))
            }

            try await Task.sleep(for: .seconds(2))
            await setResult(DetectionResult(detection: .fire,
                                            confidence: 0.55))
        } catch {
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
