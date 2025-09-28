//
//  SearchBarView.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
        HStack {
            Image(systemName: Constants.Images.searchIcon)
                .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .medium))
            
            TextField(Constants.Labels.searchPlaceholder, text: $text)
            
            }
        .padding(Constants.UI.defaultSpacing)
            .background(Color(.systemGray6))
            .cornerRadius(Constants.UI.imageCornerRadius)
        }
        .padding(.horizontal)
    }
}
