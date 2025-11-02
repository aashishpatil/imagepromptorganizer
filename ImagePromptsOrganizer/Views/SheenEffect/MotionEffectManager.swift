// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Adapted from an initial generation from Gemini 2.5

import CoreMotion
import Foundation
import Combine

import Observation

@Observable
class MotionEffectManager {
    
    private let motionManager = CMMotionManager()
    
    static let manager = MotionEffectManager()
    
    // Publish properties for roll and pitch so SwiftUI can react to changes
    var roll: Double = 0.0
    var pitch: Double = 0.0
    
    var startPointX: Double = 0.0
    var startPointY: Double = 0.0
    
    var inverseStartPointX: Double = 1.0
    var inverseStartPointY: Double = 1.0

    init() {
        // Only start updates if the device motion is available
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion is not available.")
            return
        }
        
        // Set the update interval (e.g., 60 times per second)
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        
        // Start device motion updates on the main queue
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let self = self, let motion = data?.attitude else { return }
            
            // Update the published properties with new motion data
            self.roll = motion.roll
            self.pitch = motion.pitch
            
            // Compute startPoints for lighter color
            self.startPointX = convertUsingSin(CGFloat(roll) * (effectIntensity/3))
            self.startPointY = convertUsingSin(CGFloat(pitch) * -(effectIntensity/3))
            
            self.inverseStartPointX = 1.0 - startPointX
            self.inverseStartPointY = 1.0 - startPointY
        }
    }
    
    let effectIntensity: CGFloat = 20
    
    // Create a function to make the conversion reusable
    func convertUsingSin(_ value: Double) -> Double {
        // 1. Calculate the sine of the input value.
        // The sin() function expects a value in radians.
        let sineResult = sin(value)
        
        // 2. Map the -1.0 to 1.0 range to 0.0 to 1.0.
        return (sineResult + 1.0) / 2.0
    }
    
    deinit {
        // Stop motion updates when the manager is deinitialized
        motionManager.stopDeviceMotionUpdates()
    }
}
