//
//  FavoritesViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    private let persistanceService: PersistanceServiceProtocol
    
    @Published var favoriteShows = [FavoriteData.Show]()
    @Published var isShowSaved   = Bool()
    
    init(persistanceService: PersistanceServiceProtocol) {
        self.persistanceService = persistanceService
    }
    
    func loadFavorites() {
        favoriteShows = persistanceService.favoriteData.favorites
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
    
    func toggleFavorite(_ show: FavoriteData.Show) {
        var favorites = persistanceService.favoriteData.favorites
        
        if isInFavoritesArray(show) {
            if let index = favorites.firstIndex(where: { $0.id == show.id }) {
                favorites.remove(at: index)
                isShowSaved = false
            }
        } else {
            favorites.insert(show, at: favorites.endIndex)
            isShowSaved = true
        }
        persistanceService.favoriteData = FavoriteData(favorites: favorites, favorite: show, iconChecked: isShowSaved)
    }
    
    func persistChecked(_ iconChecked: Bool) {
        let checked = persistanceService.favoriteData.setIconState(iconChecked)
        persistanceService.favoriteData.iconChecked = checked
    }
}
