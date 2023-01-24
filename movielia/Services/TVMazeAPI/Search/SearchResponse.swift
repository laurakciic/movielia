//
//  SearchResponse.swift
//  movielia
//
//  Created by Laura on 29.10.2022..
//

import Foundation

struct SearchResponse: Codable {
    let show: Show?
    
    struct Show: Codable, Identifiable {
        let id:        Int
        let name:      String
        let genres:    [String]
        let premiered: String
        let ended:     String?
        let image:     Image?
        let summary:   String?
        
        var yearPremiered: String {
            let index = premiered.index(premiered.startIndex, offsetBy: 4)
            let year = String(premiered[..<index])
            return year
        }
        
        var yearEnded: String {
            let index = ended!.index(ended!.startIndex, offsetBy: 4)
            let year = String(ended![..<index])
            return year
        }
    }

    struct Image: Codable {
        let medium:   URL?
        let original: URL?
    }
}
