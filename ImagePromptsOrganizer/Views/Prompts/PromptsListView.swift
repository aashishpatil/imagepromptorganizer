//
//  PromptsListView.swift
//  ImagePromptsOrganizer
//
//  Created by Aashish Patil on 10/9/25.
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

struct PromptsListView: View {
    
    @Environment(AppState.self) var appState
    
    @Environment(\.dismiss) var dismiss
    
    @State var errorMessage: String = ""
    
    var mediaPromptsRef = DataConnect.mediaPromptsConnector.listMediaPromptsQuery.ref()
    
    var body: some View {
        VStack {
            if let prompts = mediaPromptsRef.data?.mediaPrompts {
                List {
                    ForEach(prompts) { prompt in
                        Text(prompt.name)
                            .onTapGesture {
                                appState.selectedFilter = prompt
                                dismiss()
                            }
                        
                    }
                    .onDelete(perform: deletePrompt)
                    //.listRowSeparator(.hidden)
                    //.listRowBackground(Color.clear)
                
                }
                //.scrollContentBackground(.hidden)
                //.background(Color.clear)
            } else {
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                    //TODO: Add retry button
                } else {
                    ProgressView()
                        .controlSize(.large)
                }
            }
        }
        .task {
            do {
                _ = try await mediaPromptsRef.execute()
            } catch {
                Logger.prompts.error("Error loading prompts \(error)")
            }
        }
    } //body
    
    func deletePrompt(at offsets: IndexSet) {
        guard let mediaPrompts = mediaPromptsRef.data?.mediaPrompts else {
            return
        }
        
        let prompts = offsets.map { index in
            mediaPrompts[index]
        }
        
        guard let first = prompts.first else {
            return
        }
        
        Task {
            do {
                let result = try await DataConnect.mediaPromptsConnector.deletePromptMutation.execute(id: first.id)
                Logger.prompts.debug("Deleted \(String(describing: result))")
            } catch {
                Logger.prompts.error("Error deleting prompt \(error)")
            }
        }
            
    }
}
