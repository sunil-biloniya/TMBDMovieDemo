//
//  CharacterCard.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI

private struct CardImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}

private struct CardLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.caption, design: .rounded))
            .foregroundColor(.gray)
    }
}

private struct CardContainerBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Color(.systemGray6)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 8)
            )
    }
}

extension View {
    func cardImageStyle() -> some View {
        modifier(CardImageModifier())
    }
    
    func cardLabelStyle() -> some View {
        modifier(CardLabelModifier())
    }
    
    func cardContainerBackground() -> some View {
        modifier(CardContainerBackgroundModifier())
    }
}
