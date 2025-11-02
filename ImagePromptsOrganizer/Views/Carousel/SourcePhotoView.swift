//
//  SourcePhotoView.swift
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

import SwiftUI
import CoreTransferable
import PhotosUI

import OSLog


struct SourcePhotoView: View {
    
    @Environment(AppState.self) var appState
    @Environment(AppStyle.self) var appStyle
    
    @State var pickedPhoto: PhotosPickerItem?
    
    @State var filterSheet: FilterSheetKind? = nil
    
    var body: some View {
        VStack {
            if let sourcePhoto = appState.sourcePhoto?.state {
                switch sourcePhoto {
                case .empty: Text("") //put placeholder here
                case .available(let uiImage):
                    VStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: appStyle.imageCornerRadius))
                            .modifier(SheenEffectModifier())
                            .onTapGesture {
                                self.filterSheet = .fullImage
                            }
                    }
                case .loading(_):
                    ProgressView()
                case .failed(let error):
                    PhotoErrorView(error: error)
                }
                
            } else {
                Image(uiImage: appState.placeholderImage)
            }
            Spacer()
            // TODO: This button bar should be a separate view
            HStack(spacing: 15) {
                PhotosPicker(selection: $pickedPhoto,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .modifier(RoundButtonModifier())
                }
                Button {
                    filterSheet = .defined
                } label: {
                    Image(systemName: "arrow.right.filled.filter.arrow.right")
                        //.symbolRenderingMode(.multicolor)
                        .modifier(RoundButtonModifier())
                }
                Button {
                    filterSheet = .createFilter
                } label: {
                    Image(systemName: "widget.small.badge.plus")
                        //.symbolRenderingMode(.multicolor)
                        .modifier(RoundButtonModifier())
                }
            }
        } // vstack
        .padding()
        .onChange(of: pickedPhoto) { oldValue, newValue in
            if let newValue {
                appState.loadTransferable(from: newValue)
                
                // reset it so next picker view doesn't include this
                self.pickedPhoto = nil
                appState.generatedImage = nil
            }
        }
        .sheet(item: $filterSheet) { sheetKind in
            switch sheetKind {
            case .defined:
                PromptsListView()
                    .presentationDetents([.medium])
                    /*
                    .onTapGesture {
                        filterSheet = nil
                    }*/
            case .createFilter:
                CreatePromptView()
            
            case .fullImage:
                if let sourcePhoto = appState.sourcePhoto,
                   case let .available(uiImage) = sourcePhoto.state {
                    AdvancedZoomableImage(displayImage: uiImage)
                }
            }
        }
        
    }
}
