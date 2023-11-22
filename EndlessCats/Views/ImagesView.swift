//
//  ImagesView.swift
//  EndlessCats
//
//  Created by Матвей on 10.11.2023.
//

import SwiftUI

struct ImagesView: View {
    @StateObject private var viewModel = ImagesViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.images, id: \.id) { image in
                        NavigationLink(destination: ImageDetailView(cat: image)) {
                            ImageLoadingView(url: image.url)
                                .onAppear {
                                    viewModel.loadMoreContentIfNeeded(currentItem: image)
                                }
                        }
                    }
                }
            }
            .padding(.top, Constants.UI.imagesScrollTopPadding)
            .navigationTitle(Constants.UI.navigationTitle)
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
        }
    }
}

#Preview {
    ImagesView()
}
