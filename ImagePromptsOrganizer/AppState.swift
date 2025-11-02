//
//  AppState.swift
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
import UIKit
import PhotosUI
import Observation

import MediaPromptsData
import FirebaseAI

typealias MediaPrompt = MediaPromptsData.ListMediaPromptsQuery.Data.MediaPrompt

@Observable
class AppState {
    
    // MARK:  Source Image
    
    var sourcePhoto: StatefulImage? = StatefulImage(state: .available(UIImage(named: "GeminiGenDefault")!))
    
    var placeholderImage = UIImage(systemName: "photo")!
    
    func loadTransferable(from imageSelection: PhotosPickerItem)   {
        imageSelection.loadTransferable(type: SourcePhotoTransferable.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sourcePhoto?):
                    self.sourcePhoto = StatefulImage(state:.available(sourcePhoto.uiImage))
                    print("Just set image")
                case .success(nil):
                    self.sourcePhoto = nil
                case .failure(let error):
                    self.sourcePhoto = StatefulImage(state: .failed(error))
                }
            }
        }
    }
    
    // MARK: Filter
    
    // prompt => index of StatefulImage
    // reuse already generated image if prompt has been applied.
    @ObservationIgnored
    var appliedFilters = [MediaPromptKey: StatefulImage]()
    
    var generatedImage: StatefulImage?
    
    var selectedFilter: MediaPrompt? = nil {
        didSet {
            if let selectedFilter {
                applyPrompt(prompt: selectedFilter)
            }
            Logger.photos.debug("Select prompt")
        }
    }
    
    func applyPrompt(prompt: MediaPrompt) {
        Logger.photos.debug("applying prompt \(prompt.name)")
        
        // check if we have already applied this filter
        if let gi = appliedFilters[prompt.mediaPromptKey] {
            generatedImage = gi
        }
        
        Task {
            let s = StatefulImage(state: .loading(ProgressView()), prompt: prompt)
            generatedImage = s
            
            if case let .available(uiImage) = sourcePhoto?.state,
               let imgPart = uiImage.partsValue.first
            {
                do {
                    let imgData = try await ChatManager.manager.transformImage(prompt.prompt, image: imgPart)
                    if let imgData,
                        let uiImage = UIImage(data: imgData) {
                        generatedImage = .init(state: .available(uiImage), prompt: prompt)
                        Logger.photos.debug("updating gen image for \(prompt.name) ")
                    }
                } catch {
                    generatedImage = .init( state: .failed(error))
                }
            }
            
        }
    }
    
}
