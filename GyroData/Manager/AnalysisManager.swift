//
//  AnalysisManager.swift
//  GyroData
//
//  Created by Ellen J, unchain, yeton on 2022/12/26.
//

import Foundation
import CoreMotion

typealias AnalysisData = (x: Double, y: Double, z: Double)

enum AnalysisType: String, Codable {
    case accelerate = "Accelerate"
    case gyroscope = "Gyroscope"
}

//MARK: State Interface
protocol AnalysisManagerType {
    var title: String { get }
    func startAnalyze() -> AnalysisData
    func stopAnalyze()
}

//MARK: Concrete State
class Gyroscope: AnalysisManagerType {
    private let motion = CMMotionManager()
    let title = "Gyroscope"

    func startAnalyze() -> AnalysisData {
        guard motion.isGyroAvailable else {
            return (x: 0, y: 0, z: 0)
        }
        motion.gyroUpdateInterval = 0.1
        motion.startGyroUpdates()

        guard let data = self.motion.gyroData?.rotationRate else {
            return (x: 0, y: 0, z: 0)
        }
        return (x: data.x, y: data.y, z: data.z)
    }

    func stopAnalyze() {
        motion.stopGyroUpdates()
    }
}

class Accelerate: AnalysisManagerType {
    private let motion = CMMotionManager()
    let title = "Accelerate"

    func startAnalyze() -> AnalysisData {
        guard motion.isAccelerometerAvailable else {
            return (x: 0, y: 0, z: 0)
        }
        motion.accelerometerUpdateInterval = 0.1
        motion.startAccelerometerUpdates()

        guard let data = self.motion.accelerometerData?.acceleration else {
            return (x: 0, y: 0, z: 0)
        }
        return (x: data.x, y: data.y, z: data.z)
    }

    func stopAnalyze() {
        motion.stopAccelerometerUpdates()
    }
}


//MARK: Context
final class AnalysisManager {
    var analysisType: AnalysisManagerType

    init(analysisType: AnalysisManagerType) {
        self.analysisType = analysisType
    }

    func chooseAccelerate() {
        self.analysisType = Accelerate()
    }

    func chooseGyroScope() {
        self.analysisType = Gyroscope()
    }

    func startAnaylze() -> AnalysisData {
        return analysisType.startAnalyze()
    }

    func stopAnalyze() {
        analysisType.stopAnalyze()
    }
}
