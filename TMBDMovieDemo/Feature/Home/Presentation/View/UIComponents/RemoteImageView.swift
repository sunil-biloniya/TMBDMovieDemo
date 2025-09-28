//
//  RemoteImageView.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI

struct RemoteImageView: View {
    let imageURL: String?
    var height: CGFloat = Constants.UI.Card.posterHeight
    var cornerRadius: CGFloat = Constants.UI.imageCornerRadius

    @State private var image: UIImage?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                Color.gray.opacity(0.1)
                    .overlay(Text("❌").font(.largeTitle))
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .clipped()
        .cornerRadius(cornerRadius)
        .onAppear(perform: loadImage)
    }

    private func loadImage() {
        guard let urlString = imageURL, let url = URL(string: urlString) else { return }

        if let cachedImage = ImageCache.shared.getImage(urlString) {
            self.image = cachedImage
            return
        }

        isLoading = true

        URLSession.shared.dataTask(with: url) { data, response, error in
            isLoading = false
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }

            ImageCache.shared.saveImage(urlString, downloadedImage)

            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }
        .resume()
    }
}
