//
//  ImageDetailView.swift
//  EndlessCats
//
//  Created by Матвей on 10.11.2023.
//

import SwiftUI

struct ImageDetailView: View {
    
    let cat: CatImageModel
    
    @State private var scale: CGFloat = 1.0
 
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Origin: \(cat.breeds?.first?.origin ?? "Russia")")
                    Text("Temperament: \(cat.breeds?.first?.temperament ?? "Active")")
                    Text("LifeSpan: \(cat.breeds?.first?.lifeSpan ?? "10-12")")
                    
                    if let wikiUrl = cat.breeds?.first?.wikipediaUrl, let url = URL(string: wikiUrl) {
                        Link("Link to Wikipedia", destination: url)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .navigationTitle("Cat \(cat.breeds?.first?.name ?? "Cat")")
                .navigationBarTitleDisplayMode(.inline)
                
                ImageLoadingView(url: cat.url)
                    .scaledToFit()
                    .scaleEffect(scale)
                    .frame(width: geometry.size.width)
                    .aspectRatio(contentMode: .fit)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value.magnitude
                            }
                    )
            }
        }
    }
}

#Preview {
    ImageDetailView(cat: CatImageModel(id: "0XYvRd7oD", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg", width: 1204, height: 1445, breeds: [CatBreedModel(id: "abys", name: "Abyssinian", temperament: "Active, Energetic, Independent, Intelligent, Gentle", origin: "Egypt", lifeSpan: "14 - 15", wikipediaUrl: "https://en.wikipedia.org/wiki/Abyssinian_(cat)")]))
}
