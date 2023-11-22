//
//  ImageLoadingViewModel.swift
//  EndlessCats
//
//  Created by Матвей on 10.11.2023.
//

import Foundation
import SwiftUI

final class ImageLoadingViewModel: ObservableObject {
    
    let url: String?
    
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var image: UIImage?
    
    private let networkingService = NetworkingService()
    
    init(url: String?) {
        self.url = url
    }
    func loadImage() {
        Task { [weak self] in
            
            guard let self = self else {
                return
            }
            
            guard self.image == nil && !self.isLoading,
                  let urlString = self.url,
                  let fetchUrl = URL(string: urlString) else {
                Task { @MainActor in
                    self.errorMessage = "Fetching images..."
                }
                return
            }
            
            Task { @MainActor in
                self.isLoading = true
                self.errorMessage = nil
            }
            
            do {
                let loadedImage = try await networkingService.loadImage(from: fetchUrl)
                Task { @MainActor in
                    self.image = loadedImage
                    self.isLoading = false
                }
            } catch {
                Task { @MainActor in
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
