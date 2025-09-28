//
//  DetailsPage.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//


import SwiftUI
import SwiftData

struct DetailsPage: View {
    @State var result: CResult
    @State private var isBookmarked = false
    @StateObject var viewmodel: HomeViewModel
    @Query var characters: [CResult]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                RemoteImageView(imageURL: result.image, height: Constants.UI.Details.posterHeight, cornerRadius: 0)
                .padding(.vertical, Constants.UI.defaultCornerRadius)
            }
        }

        .navigationTitle(result.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleBookmark()
                  
                }) {
                    Image(systemName: result.isBookmarked ? Constants.Images.bookMarkFillIcon : Constants.Images.bookMarkIcon)
                        .foregroundColor(result.isBookmarked ? .red : .primary)
                }
            }
        }
    }
    
    func toggleBookmark() {
        let isBookmarked = viewmodel.bookMark(result: result, allResult: characters)
        self.isBookmarked = isBookmarked ? false : true
    }
}

#Preview {
   // DetailsPage()
}
