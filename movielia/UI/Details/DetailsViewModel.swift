//
//  DetailsViewModel.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

final class DetailsViewModel<T>: ObservableObject {
    
    var data: T
    let cast: [CastResponse]
    private let persistanceService: PersistanceServiceProtocol
    @Published var isSaved = Bool()
    
    var onDismissed: (() -> Void)?

    init(data: T, cast: [CastResponse], persistanceService: PersistanceServiceProtocol) {
        self.data = data
        self.cast = cast
        self.persistanceService = persistanceService
    }
    
    func containsFavorite(_ show: ShowsResponse) -> Bool {
        let favorites = persistanceService.favoriteData.favorites
        
        for favorite in favorites {
            if favorite.id == show.id {
                return true
            }
        }
        return false
    }
    
    func containsFavorite(_ showFromSchedule: ScheduleResponse) -> Bool {
        let favorites = persistanceService.favoriteData.favorites
        
        for favorite in favorites {
            if favorite.id == showFromSchedule.id {
                return true
            }
        }
        return false
    }
    
    func isInFavoritesArray(_ show: FavoriteData.Show) -> Bool {
        let favorites = persistanceService.favoriteData.favorites
        
        for favorite in favorites {
            if favorite.id == show.id {
                return true
            }
        }
        return false
    }
    
    func toggleFavorite(_ show: ShowsResponse) {
        let show = persistanceService.favoriteData.favorite.createFavorite(from: show)
        var favoriteShows = persistanceService.favoriteData.favorites
        
        if isInFavoritesArray(show) {
            if let index = favoriteShows.firstIndex(where: { $0.id == show.id }) {
                favoriteShows.remove(at: index)
                isSaved = false
            }
        } else {
            favoriteShows.insert(show, at: favoriteShows.endIndex)
            isSaved = true
        }
        persistanceService.favoriteData = FavoriteData(favorites: favoriteShows, favorite: show, iconChecked: isSaved)
    }
    
    func toggleFavorite(_ showFromSchedule: ScheduleResponse) {
        let show = persistanceService.favoriteData.favorite.createFavorite(from: showFromSchedule)
        var favoriteShows = persistanceService.favoriteData.favorites
        
        if isInFavoritesArray(show) {
            if let index = favoriteShows.firstIndex(where: { $0.id == show.id }) {
                favoriteShows.remove(at: index)
                isSaved = false
            }
        } else {
            favoriteShows.insert(show, at: favoriteShows.endIndex)
            isSaved = true
        }
        persistanceService.favoriteData = FavoriteData(favorites: favoriteShows, favorite: show, iconChecked: isSaved)
    }
    
    func persistChecked(_ iconChecked: Bool) {
        let checked = persistanceService.favoriteData.isIconChecked(iconChecked)
        persistanceService.favoriteData.iconChecked = checked
    }
}
