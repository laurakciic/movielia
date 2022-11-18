//
//  ScheduleResponse.swift
//  movielia
//
//  Created by Laura on 20.10.2022..
//

import Foundation

struct ScheduleResponse: Identifiable, Codable {
    let id:      Int
    let airtime: String
    
    let show: Show
    struct Show: Codable {
        let id:      Int
        let name:    String
        let image:   Image?
        let summary: String?
        
        var summaryWithoutHTMLTags: String {
            return summary?.removeHTMLTags() ?? "Summary not available."
        }
    }
    
    struct Image: Codable {
        let medium:   URL?
        let original: URL?
    }
}
