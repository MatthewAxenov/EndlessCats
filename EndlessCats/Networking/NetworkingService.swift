//
//  NetworkingService.swift
//  EndlessCats
//
//  Created by Матвей on 21.11.2023.
//

import Foundation
import SwiftUI

final class NetworkingService {
    
    func fetchImagesData(limit: Int, page: Int) async throws -> [CatImageModel] {
        let apiKey = Constants.Networking.apiKey
        let urlString = "https://api.thecatapi.com/v1/images/search?limit=\(limit)&page=\(page)&has_breeds=1&api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingError.invalidResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode([CatImageModel].self, from: data)
    }
    
    func loadImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode),
              let image = UIImage(data: data) else {
            throw NetworkingError.invalidResponse
        }
        return image
    }
}


enum NetworkingError: Error {
    case invalidURL
    case noData
    case invalidResponse
}

