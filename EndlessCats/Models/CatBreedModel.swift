//
//  CatBreedModel.swift
//  EndlessCats
//
//  Created by Матвей on 10.11.2023.
//

import Foundation

struct CatBreedModel: Identifiable, Decodable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let lifeSpan: String?
    let wikipediaUrl: String?
}
