//
//  ImagesViewModel.swift
//  EndlessCats
//
//  Created by Матвей on 10.11.2023.
//

import Foundation

final class ImagesViewModel: ObservableObject {
    @Published private(set) var images: [CatImageModel] = []
    @Published private(set) var selectedImage: CatImageModel?
    @Published private(set) var isDetailViewPresented = false
    
    private let networkingService = NetworkingService()
        
    private var currentPage = 0
    
    init() {
        loadMoreContent()
    }
    
    func loadMoreContentIfNeeded(currentItem item: CatImageModel?) {
        guard let item = item else { return }

        let thresholdIndex = images.index(images.endIndex, offsetBy: -5)
        if images.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    private func loadMoreContent() {
        Task {
            do {
                currentPage += 1
                let newImages = try await networkingService.fetchImagesData(limit: 10, page: currentPage)
                Task { @MainActor in
                    self.images.append(contentsOf: newImages)
                }
            } catch {
                print("Error fetching images: \(error.localizedDescription)")
            }
        }
    }
}

