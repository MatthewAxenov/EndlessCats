//
//  CatImageModel.swift
//  EndlessCats
//
//  Created by Матвей on 10.11.2023.
//

import Foundation

struct CatImageModel: Identifiable, Decodable {
    let id: String
    let url: String
    let width: Int?
    let height: Int?
    let breeds: [CatBreedModel]?
}
