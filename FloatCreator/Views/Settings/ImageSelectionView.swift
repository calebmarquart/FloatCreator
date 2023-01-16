//
//  ImageSelectionView.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-14.
//

import SwiftUI
import PhotosUI

struct ImageSelectionView: View {
    @AppStorage("image_data") private var imageData = Data()
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24.0) {
                Text("When you print a receipt, you can format a logo at the top. Please upload a photo to use as your company logo if you choose to do so.")
                
                if let image = image {
                    Text("Selected Image:")
                        .font(.headline)
                    
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(maxHeight: 300)
                    
                    HStack(spacing: 20) {
                        PhotosPicker("Choose Other", selection: $selectedPhoto)
                            
                        
                        Button("Remove Image") {
                            selectedPhoto = nil
                            self.image = nil
                            imageData = Data()
                        }
                        .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                } else {
                    PhotosPicker("Choose Photo", selection: $selectedPhoto)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .onChange(of: selectedPhoto) { newPhoto in
                showImage(photo: newPhoto)
            }
            .padding()
            .navigationTitle("Logo Selection")
            .onAppear {
                if let uiImage = imageData.toImage() {
                    image = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    private func showImage(photo: PhotosPickerItem?) {
        Task {
            guard let data = try? await photo?.loadTransferable(type: Data.self) else { return }
            guard let uiimage = data.toImage() else { return }
            image = Image(uiImage: uiimage)
            imageData = data
        }
    }
    
}

struct ImageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ImageSelectionView()
        }
    }
}
