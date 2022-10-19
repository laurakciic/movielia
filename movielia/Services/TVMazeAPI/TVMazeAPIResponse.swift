//
//  TvMazeAPIResponse.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

struct TVMazeAPIResponse: Codable {
    let movie: [Movie]
    
    struct Movie: Codable {
        let id:          Int
        let name:        String
        let image:       String
        let rating:      String
        let description: String
        let timePlaying: String
        let releaseYear: String
        
        let actor: [Actor]
        
        struct Actor: Codable {
            let image:     String
            let realName:  String
            let movieName: String
        }
    }
}
