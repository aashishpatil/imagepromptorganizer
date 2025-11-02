//
//  StatefulImage.swift
//  ImagePromptsOrganizer
//
//  Created by Aashish Patil on 10/10/25.
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
import MediaPromptsData

struct StatefulImage: Identifiable, Equatable, Hashable {
    
    enum State {
        case empty
        case available(UIImage)
        case loading(any View)
        case failed(Error)
    }
    
    private(set) var state: State = .empty
    private(set) var prompt: MediaPrompt? = nil
    
    var id: String {
        if let prompt {
            return "\(prompt.id.uuidString)-\(state)"
        } else {
            return "sourcePhoto \(state)"
        }
    }
    
    init(state: State, prompt: MediaPrompt? = nil) {
        self.state = state
        self.prompt = prompt
    }
    
    static func == (lhs: StatefulImage, rhs: StatefulImage) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
