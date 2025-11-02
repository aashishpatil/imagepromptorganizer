//
//  SheenEffectModifier.swift
//  TestImageView
//
//  Created by Aashish Patil on 10/12/25.
//
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

import SwiftUI

struct SheenEffectModifier: ViewModifier {
    var motionManager = MotionEffectManager.manager
    
    func body(content: Content) -> some View {
        content
            .padding(2)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(
                        .linearGradient(
                            colors: [
                                .white.opacity(0.10),
                                .white.opacity(0.05)
                            ],
                            startPoint: .init(x: motionManager.inverseStartPointX, y: motionManager.inverseStartPointY),
                            endPoint: .init(x: motionManager.startPointX, y: motionManager.startPointY)
                        ),
                        lineWidth: 6
                    )
                    //.blur(radius: 20.0)
            )
            .overlay(
                
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(
                        .linearGradient(
                            colors: [
                                .white.opacity(0.21),
                                .white.opacity(0.07)
                            ],
                            startPoint: .init(x: motionManager.startPointX, y: motionManager.startPointX),
                            endPoint: .init(x: motionManager.inverseStartPointX, y: motionManager.inverseStartPointY)
                        ),
                        lineWidth:4
                    )
                    //.fill(EllipticalGradient(colors: [Color.yellow.opacity(0.08), Color.white.opacity(0.10), Color.white.opacity(0.02), Color.clear], center: .init(x: motionManager.startPointX, y: motionManager.startPointY)))
                    
                    .fill(RadialGradient(colors: [Color.white.opacity(0.21), Color.clear], center: .init(x: motionManager.startPointX, y: motionManager.startPointY), startRadius: 8.0, endRadius: 240.0))
            )
            .shadow(color: .black.opacity(0.34), radius: 10, x: 0, y: 10)
            .offset(
                x: CGFloat(motionManager.roll) * (motionManager.effectIntensity / 2),
                y: CGFloat(motionManager.pitch) * -(motionManager.effectIntensity / 2)
                            )
    }
    
}

extension Image {
    func applySheenEffect() -> some View {
        self.modifier(SheenEffectModifier())
    }
}
