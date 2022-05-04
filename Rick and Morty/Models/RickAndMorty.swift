//
//  RickAndMorty.swift
//  Rick and Morty
//
//  Created by Maksim  on 27.04.2022.
//

import Foundation

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
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
    
    var description: String {
        """
    Name: \(name)
    Status: \(status)
    Species: \(species)
    Gender: \(gender)
    Origin: \(origin.name)
    Location: \(location.name)
    """
    }
}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    
    var description: String {
        """
    Title: \(name)
    Date: \(airDate)
    """
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
        case episode
        case characters
    }
    
}

enum Link: String {
    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
}
