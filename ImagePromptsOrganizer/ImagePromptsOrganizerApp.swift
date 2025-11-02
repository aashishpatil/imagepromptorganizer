//
//  ImagePromptsOrganizerApp.swift
//  ImagePromptsOrganizer
//
//  Created by Aashish Patil on 10/4/25.
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

import Firebase
import FirebaseAuth
import FirebaseDataConnect
import MediaPromptsData


@main
struct ImagePromptsOrganizerApp: App {
    
    private var authManager: AuthManager
    private var appState = AppState()
    private var appStyle = AppStyle.standard
    
    init() {
        FirebaseApp.configure()
        
        #if targetEnvironment(simulator)
        DataConnect.mediaPromptsConnector.useEmulator()
        #endif
        
        // do this after configure otherwise there isn't a configured FirebaseApp
        authManager = AuthManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(authManager)
        .environment(appState)
        .environment(appStyle)
    }
}
