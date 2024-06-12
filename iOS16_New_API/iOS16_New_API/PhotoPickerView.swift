//
//  PhotoPickerView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @StateObject private var photosModel: PhotosPickerModel = .init()
    var body: some View {
        VStack {
            VStack {
                if photosModel.loadedImages.isEmpty == false {
                    TabView {
                        ForEach(photosModel.loadedImages) { mediaFile in
                            mediaFile.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                                .clipped()
                        }
                    }
                    .padding()
                    .tabViewStyle(.page(indexDisplayMode: .always))
                }
            }
            .navigationTitle("Photo Picker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $photosModel.selection, matching: .any(of: [.images]), preferredItemEncoding: .automatic, photoLibrary: .shared()) {
                        Image(systemName: "photo.fill")
                            .font(.callout)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $photosModel.selections, matching: .any(of: [.images]), preferredItemEncoding: .automatic, photoLibrary: .shared()) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.callout)
                    }
                }
            }
        }
    }
}

class PhotosPickerModel: ObservableObject {
    @Published var loadedImages: [MediaFile] = []
    @Published var selection: PhotosPickerItem? {
        didSet {
            if let selectionPhoto = selection {
                processPhoto(photo: selectionPhoto)
            }
        }
    }
    @Published var selections: [PhotosPickerItem] = [] {
        didSet {
            for selectionPhoto in selections {
                processPhoto(photo: selectionPhoto)
            }
        }
    }
    
    func processPhoto(photo: PhotosPickerItem) {
        photo.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data, let image = UIImage(data: data) {
                        self.loadedImages.append(.init(image: Image(uiImage: image), data: data))
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}


struct MediaFile: Identifiable {
    var id: String = UUID().uuidString
    var image: Image
    var data: Data
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}
