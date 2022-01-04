//
//  PersonModel.swift
//  Feedloop
//
//  Created by Ricky Austin on 04/01/22.
//

import Foundation

struct PageModel: Decodable{
    let count: Int
    let next: String
    let results: [PersonModel]
}

struct PersonModel: Decodable{
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case homeworld, films, species, vehicles, starships, created, edited, url
    }
}
