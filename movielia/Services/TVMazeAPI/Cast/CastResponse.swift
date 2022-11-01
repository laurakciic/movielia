//
//  CastResponse.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import Foundation

struct CastResponse: Codable {
    let person: Person?
    
    struct Person: Codable {
        let id:        Int
        let name:      String
        let image:     Image?
        let character: Character?
    }
    
    struct Image: Codable {
        let medium: URL?
    }
    
    struct Character: Codable {
        let name: String
    }
}
