//
//  FavoriteData.swift
//  movielia
//
//  Created by Laura on 01.11.2022..
//

import Foundation

struct FavoriteData: Codable {
    
    let favorites: [Show]
    let favorite:  Show
    
    var iconChecked: Bool
        
    struct Show: Codable, Identifiable {
        let id:    Int
        let image: URL?
        let summary: String
        
        func createFavorite(from showData: ShowsResponse) -> Show {
            return Show(id: showData.id, image: showData.image.medium, summary: showData.summary)
        }
        
        func createFavorite(from scheduleData: ScheduleResponse) -> Show {
            return Show(id: scheduleData.id, image: scheduleData.show.image?.medium, summary: scheduleData.show.summary ?? "")
        }
    }
    
    mutating func setIconState(_ bool: Bool) -> Bool {
        iconChecked = bool
        return iconChecked
    }
    
    static var defaultFavoriteData: Self {
        FavoriteData(favorites: [], favorite: Show(id: 0, image: nil, summary: ""), iconChecked: true)
    }
}
