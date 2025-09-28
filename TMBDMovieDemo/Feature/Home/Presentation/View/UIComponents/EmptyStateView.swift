//
//  EmptyStateView.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    let systemImage: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
                
                Text(message)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
