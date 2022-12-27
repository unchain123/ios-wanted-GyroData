//
//  AnalysisType.swift
//  GyroData
//
//  Created by unchain, Ellen J, yeton on 2022/12/26.

import Foundation

enum AnalysisType: String, Codable {
    case accelerate = "accelerate"
    case gyroscope = "gyroscope"
}

struct Analysis: Codable {
    let analysisType: AnalysisType
    let x: Double
    let y: Double
    let z: Double
    let measurementTime: Date
    let savedAt: Date
}
