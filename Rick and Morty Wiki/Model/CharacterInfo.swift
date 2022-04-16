//
//  CharacterInfo.swift
//  Rick and Morty Wiki
//
//  Created by Белозеров Константин on 15.04.2022.
//

import Foundation

struct CharacterList: Decodable {
    let results: [CharacterInfo]
}

struct CharacterInfo: Decodable {
    
    let name: String
    let species: String
    let status: String
    let gender: String
    let image: String
    let episode: [String]
    let location: CharacterLocation
    
}

struct CharacterLocation: Decodable {
    let name: String
}


