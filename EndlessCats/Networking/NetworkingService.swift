//
//  NetworkingService.swift
//  EndlessCats
//
//  Created by Матвей on 21.11.2023.
//

import Foundation
import SwiftUI

final class NetworkingService {
    
    func fetchImagesData(limit: Int, page: Int, completion: @escaping (Result<[CatImageModel], Error>) -> Void) {
        let apiKey = Constants.Networking.apiKey
        let urlString = "https://api.thecatapi.com/v1/images/search?limit=\(limit)&page=\(page)&has_breeds=1&api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.noData))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let decodedResponse = try decoder.decode([CatImageModel].self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode),
                      let data = data,
                      let image = UIImage(data: data) else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response or data"])))
                    return
                }
                
                completion(.success(image))
            }
        }
        
        task.resume()
    }
}

enum NetworkingError: Error {
    case invalidURL
    case noData
}

