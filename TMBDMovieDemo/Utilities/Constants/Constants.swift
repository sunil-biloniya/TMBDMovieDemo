//
//  Constants.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

enum Constants {
   
    // MARK: - UI
    enum UI {
        static let defaultCornerRadius: CGFloat = 12
        static let defaultShadowRadius: CGFloat = 4
        static let defaultPadding: CGFloat = 16
        static let defaultSpacing: CGFloat = 8
        
        static let imageCornerRadius: CGFloat = 10
        
        
        enum Card {
            static let posterHeight: CGFloat = 200
        }
        
        enum Details {
            static let posterHeight: CGFloat = 250
        }
    }
   
    // MARK: - Navigation
    enum Navigation {
        static let character = "Characters"
        static let bookMark = "Bookmarked"
    }
    
    // MARK: - Labels
    enum Labels {
        static let searchPlaceholder = "Search characters..."
        static let unknown = "Unknown"
        static let gender = "Gender: "
        static let bookMarkNoData = "No Bookmarked data yet."
        static let charactersNoData = "No Characters data yet."
        static let noMoreData = "No more data to load"
       
        static let errorMsg = "An unknown error occurred"
        static let error = "Error"
        static let ok = "OK"
        
    }
    
    enum Images {
        static let searchIcon = "magnifyingglass"
        static let cancelIcon = "xmark.circle.fill"
        static let bookMarkFillIcon = "bookmark.fill"
        static let bookMarkCircleIcon = "bookmark.circle.fill"
        static let bookMarkIcon = "bookmark"
        static let globeIcon = "globe"
        static let locationIcon = "mappin.and.ellipse"
        static let bookMarkSlashIcon = "bookmark.slash"
        
    }
}
