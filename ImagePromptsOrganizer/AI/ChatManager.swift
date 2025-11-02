//
//  ChatManager.swift
//  TestFirebaseAI
//
//  Created by Aashish Patil on 9/26/25.
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

import Foundation

import FirebaseAI

actor ChatManager {
    static let manager = ChatManager()
    
    private let imageModelName = "gemini-2.5-flash-image"
    
    func generateImage(prompt: String) async throws -> Data? {
        let ai = FirebaseAI.firebaseAI(backend: .googleAI())
        let model = ai.generativeModel(modelName: imageModelName)
        
        do {
            let response = try await model.generateContent(prompt)
            
            for part in response.inlineDataParts {
                if part.mimeType.starts(with: "image/") {
                    return part.data
                }
            }
        }
        return nil
    }
    
    func transformImage(_ prompt: String, image: any Part) async throws -> Data? {
        let ai = FirebaseAI.firebaseAI(backend: .googleAI())
        let model = ai.generativeModel(modelName: imageModelName)
        
        do {
            let response = try await model.generateContent(prompt, image)
            for part in response.inlineDataParts {
                if part.mimeType.starts(with: "image/") {
                    return part.data
                }
            }
        }
        
        return nil
    }
    
}
