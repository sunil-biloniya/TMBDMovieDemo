//
//  RequestBody.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI

struct CharacterCardView: View {
    let character: CResult
    var completion: (() -> Void)?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.UI.defaultPadding)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 0) {
                
                // Image Section
                RemoteImageView(imageURL: character.image)
                    .cardImageStyle()
                
                // Content Section
                VStack(alignment: .leading, spacing: Constants.UI.defaultSpacing) {
                    nameSection
                    statusSpeciesSection
                    genderSection
                    originSection
                    locationSection
                    bookmarkButton
                }
                .padding(.horizontal, Constants.UI.defaultPadding)
                .padding(.vertical, Constants.UI.defaultCornerRadius)
            }
        }
        .cardContainerBackground()
        .scaleEffect(character.isBookmarked ? 1.0 : 0.98)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: character.isBookmarked)
    }
}

// MARK: - Sections
private extension CharacterCardView {
    
    var nameSection: some View {
        Text(character.name ?? "\(Constants.Labels.unknown)")
            .font(.system(.title2, design: .rounded, weight: .bold))
            .foregroundColor(.primary)
            .lineLimit(1)
    }
    
    var statusSpeciesSection: some View {
        HStack(spacing: 4) {
            Text(character.status?.rawValue ?? "")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.accentColor)
            
            Text("•")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(character.species?.rawValue ?? "")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
        }
    }
    
    var genderSection: some View {
        Text("\(Constants.Labels.gender)\(character.gender?.rawValue ?? "\(Constants.Labels.unknown)")")
            .font(.system(.footnote, design: .rounded))
            .foregroundColor(.secondary)
    }
    
    var originSection: some View {
        Group {
            if let origin = character.origin?.name {
                Label(origin, systemImage: Constants.Images.globeIcon)
                    .cardLabelStyle()
            }
        }
    }
    
    var locationSection: some View {
        Group {
            if let location = character.location?.name {
                Label(location, systemImage: Constants.Images.locationIcon)
                    .cardLabelStyle()
            }
        }
    }
    
    var bookmarkButton: some View {
        Group {
            if character.isBookmarked {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            completion?()
                        }
                    }) {
                        Image(systemName: Constants.Images.bookMarkCircleIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(
                                LinearGradient(colors: [.red, .pink],
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .padding(.trailing, Constants.UI.defaultSpacing)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 8)
            }
        }
    }
}

