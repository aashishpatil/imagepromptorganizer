//
//  TransformImage.swift
//  ImagePromptsOrganizer
//
//  Created by Aashish Patil on 10/11/25.
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

struct TransformImageView: View {
    
    @Environment(AppState.self) var appState
    @Environment(AppStyle.self) var appStyle
    
    var statefulImage: StatefulImage? = nil
    
    @State private var filterSheet: FilterSheetKind? = nil
    
    var body: some View {
        VStack(spacing: 15) {
            if let statefulImage {
                switch statefulImage.state {
                case .empty: Text("Please Pick an Image") // TODO - better view
                case .available(let uiImage):
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: appStyle.imageCornerRadius))
                        .modifier(SheenEffectModifier())
                        .onTapGesture {
                            self.filterSheet = .fullImage
                        }
                case .loading(_):
                    if case let .available(uiImage) = appState.sourcePhoto?.state {
                        ProcessingView(initialImage: uiImage)
                    } else {
                        ProgressView()
                            .controlSize(.large)
                    }
                case .failed(let error):
                    PhotoErrorView(error: error)
                }
            } // if statefulImage
            Spacer()
            HStack(spacing: 15) {
                if  let statefulImage,
                    case let .available(uiImage) = statefulImage.state {
                    
                    ShareLink(
                        item: Image(uiImage: uiImage),
                        preview: SharePreview("My Image", image: Image(uiImage: uiImage))
                    ) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .modifier(RoundButtonModifier())
                    
                    Button {
                        Task {
                            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                        }
                    } label: {
                        Image(systemName: "photo.badge.arrow.down")
                    }
                    .modifier(RoundButtonModifier())
                }
            }
        } //VStack
        .padding()
        .sheet(item: $filterSheet) { kind in
            switch kind {
            case .fullImage:
                if let transformedImage = appState.generatedImage,
                   case let .available(uiImage) = transformedImage.state {
                    AdvancedZoomableImage(displayImage: uiImage)
                }
            default:
                EmptyView()
            }
        }
        
    }
}
