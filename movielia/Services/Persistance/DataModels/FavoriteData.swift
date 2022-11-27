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
        
        func createFavorite(from showData: ShowsResponse) -> Show {
            return Show(id: showData.id, image: showData.image.medium)
        }
        
        func createFavorite(from scheduleData: ScheduleResponse) -> Show {
            return Show(id: scheduleData.id, image: scheduleData.show.image?.medium)
        }
    }
    
    mutating func setIconState(_ bool: Bool) -> Bool {
        iconChecked = bool
        return iconChecked
    }
    
    static var defaultFavoriteData: Self {
        FavoriteData(favorites: [], favorite: Show(id: 0, image: nil), iconChecked: true)
    }
}
