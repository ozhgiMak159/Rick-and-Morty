//
//  RickAndMorty.swift
//  Rick and Morty
//
//  Created by Maksim  on 27.04.2022.
//

import Foundation

struct RickAndMorty {
    let info: Info
    let results: [Character]
}

struct Info {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
}

struct Location {
    let name: String
}

struct Episode {
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
        case episode
        case characters
    }
    
    
    
}
