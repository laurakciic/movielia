//
//  PersistanceService.swift
//  movielia
//
//  Created by Laura on 31.10.2022..
//

import Foundation

final class PersistanceService: PersistanceServiceProtocol {
    
    var favoriteData: FavoriteData {
        get {
            UserDefaults.standard.load() ?? FavoriteData.defaultFavoriteData
        }
        set {
            UserDefaults.standard.save(newValue)
        }
    }
}
