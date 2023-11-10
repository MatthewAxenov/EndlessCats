//
//  ImageLoadingView.swift
//  EndlessCats
//
//  Created by Матвей on 10.11.2023.
//

import SwiftUI

struct ImageLoadingView: View {
    
    @StateObject private var imageLoadingViewModel: ImageLoadingViewModel
    
    init(url: String?) {
        _imageLoadingViewModel = StateObject(wrappedValue: ImageLoadingViewModel(url: url))
    }
    
    var body: some View {
        Group {
            if let viewModelImage = imageLoadingViewModel.image {
                Image(uiImage: viewModelImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .cornerRadius(Constants.UI.Image.cornerRadius)
                    .padding(.vertical, Constants.UI.Image.vPadding)
                    .padding(.horizontal, Constants.UI.Image.hPadding)
            } else if let errorMessage = imageLoadingViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.pink)
                    .frame(width: Constants.UI.Image.baseWidth, height: Constants.UI.Image.baseHeight)
            } else {
                ProgressView()
                    .frame(width: Constants.UI.Image.baseWidth, height: Constants.UI.Image.baseHeight)
            }
        }
        .onAppear {
            imageLoadingViewModel.loadImage()
        }
    }
}

#Preview {
    ImageLoadingView(url: Constants.UI.Image.exampleUrl)
}
