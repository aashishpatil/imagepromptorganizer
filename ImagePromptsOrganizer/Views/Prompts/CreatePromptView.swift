//
//  CreatePromptView.swift
//  ImagePromptsOrganizer
//
//  Created by Aashish Patil on 10/13/25.
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

import OSLog

import SwiftUI
import FirebaseDataConnect
import MediaPromptsData


struct CreatePromptView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    
    @State private var promptName: String = ""
    @State private var promptText: String = ""
    
    @State private var creating: Bool = false
    
    @State private var errorMessage:String = ""
    
    var body: some View {
        ZStack {
            
            Form {
                Section {
                    TextField("Name the transform", text: $promptName)
                }
                Section {
                    Text("Try out image prompts in the Gemini App and paste (or type) them here")
                        .font(.footnote)
                        
                    TextEditor(text: $promptText)
                        .frame(minHeight: 150)
                }
                
                Section {
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation {
                                creating = true
                            }
                            Task {
                                do {
                                    let result = try await DataConnect.mediaPromptsConnector.addPromptMutation.execute(name: promptName, prompt: promptText)
                                    Logger.prompts.debug("Created prompt \(result.data.mediaPrompt_insert.id)")
        
                                    dismiss()
                                } catch {
                                    errorMessage = "Error creating the transform"
                                    Logger.prompts.error("Error creating prompt \(error)")
                                }
                                creating = false
                            }
                        } label: {
                            Text("Create Filter")
                        }
                        .buttonStyle(.glass)
                        Spacer()
                    } //HStack for button
                } // Button Section
            }// Form
            if creating {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .controlSize(.large)
                        Spacer()
                    }
                    Spacer()
                }
                .background(Color.black.opacity(0.6))
            }
        }// ZStack
    }
}
