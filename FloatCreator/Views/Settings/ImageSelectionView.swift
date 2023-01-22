//
//  ImageSelectionView.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-14.
//

import SwiftUI

struct ImageSelectionView: View {
    @AppStorage("image_data") private var imageData = Data()
    @State private var showingImageSelector = false
    @State private var image: UIImage?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24.0) {
                Text("When you print a receipt, you can format a logo at the top. Please upload a photo to use as your company logo if you choose to do so.")
                
                if let uiimage = image {
                    if let image = Image(uiImage: uiimage) {
                        
                        Text("Selected Image:")
                            .font(.headline)
                        
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(maxHeight: 300)
                        
                        HStack(spacing: 20) {
                            Button("Change Image") {
                                showingImageSelector = true
                            }
                            
                            
                            Button("Remove Image") {
                                self.image = nil
                                imageData = Data()
                            }
                            .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        chooseImageView
                    }
                } else {
                    chooseImageView
                }
            }
            .padding()
            .navigationTitle("Logo Selection")
            .onAppear {
                if let uiImage = imageData.toImage() {
                    image = uiImage
                }
            }
            .onChange(of: image) { newPhoto in
                if let image = newPhoto {
                    imageData = image.pngData() ?? Data()
                }
            }
            .sheet(isPresented: $showingImageSelector) {
                ImageSelectionViewRepresentable(image: $image)
            }
        }
    }
    
    var chooseImageView: some View {
        Button("Choose Image") {
            showingImageSelector = true
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct ImageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ImageSelectionView()
        }
    }
}
