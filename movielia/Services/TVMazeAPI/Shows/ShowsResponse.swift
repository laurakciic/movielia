//
//  TvMazeAPIResponse.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

struct ShowsResponse: Identifiable, Codable {
    let id:      Int
    let name:    String
    
    let image: Image
    struct Image: Codable {
        let medium: URL?
    }
    
    let rating: Rating
    struct Rating: Codable {
        let average: Double?
    }
}
