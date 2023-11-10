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
        
        guard image == nil && !isLoading, let urlString = url, let fetchUrl = URL(string: urlString) else {
            errorMessage = "Bad request"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        networkingService.loadImage(from: fetchUrl) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
