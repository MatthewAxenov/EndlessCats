//
//  Constants.swift
//  EndlessCats
//
//  Created by Матвей on 21.11.2023.
//

import Foundation

enum Constants {
    
    enum UI {
        public static let imagesScrollTopPadding = 20.0
        public static let navigationTitle = "Endless cats"
        
        enum Image {
            public static let baseHeight = 200.0
            public static let baseWidth = 300.0
            public static let cornerRadius = 10.0
            public static let vPadding = 10.0
            public static let hPadding = 20.0
            public static let exampleUrl = "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"
        }

    }
    
    enum Networking {
        public static let urlMemoryCapacity = 1024 * 1024 * 64
        public static let apiKey = "live_hewK7TUIKUBUUTVlKhI93jT6l4oQjyZts1T0RKBebWuDUxXZKkrYPXwHcfuGoqhH"
    }
    
}
