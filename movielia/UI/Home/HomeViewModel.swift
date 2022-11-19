//
//  HomeViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit

final class HomeViewModel<T>: ObservableObject {
    
    private let showsService:       ShowsServiceProtocol
    private let scheduleService:    ScheduleServiceProtocol
    private let castService:        CastServiceProtocol
    private let persistanceService: PersistanceServiceProtocol
    
    var onGoToDetails: ((_ object: T, _ cast: [CastResponse]) -> Void)?
    
    @Published var shows       = [ShowsResponse]()
    @Published var schedule    = [ScheduleResponse]()
    @Published var cast        = [CastResponse]()
    @Published var isSaved     = Bool()
    
    init(showsService: ShowsServiceProtocol, scheduleService: ScheduleServiceProtocol, castService: CastServiceProtocol, persistanceService: PersistanceServiceProtocol) {
        self.showsService       = showsService
        self.scheduleService    = scheduleService
        self.castService        = castService
        self.persistanceService = persistanceService
    }
    
    func fetchMovieData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.showsService.fetchShows { result in
                
                DispatchQueue.main.async {
                    switch(result) {
                    case .success(let response):
                        self.shows.append(contentsOf: response)
                        
                    case .failure(let error):
                        print("Error occured while fetching show data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchScheduleData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.scheduleService.fetchSchedule() { result in
                DispatchQueue.main.async {
                    switch(result) {
                    case .success(let response):
                        self.schedule.append(contentsOf: response)
                        
                    case .failure(let error):
                        print("Error occured while fetching schedule data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchCastData(_ movie: Int) {
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let self = self else { return }

        self.castService.fetchCast(for: movie) { result in
//                DispatchQueue.main.async {
                    switch(result) {
                    case .success(let response):
                        self.cast.append(contentsOf: response)
                        
                    case .failure(let error):
                        print("Error occured while fetching cast data: \(error.localizedDescription)")
                    }
//                }
//            }
        }
    }
    
    func emptyCastArray() {
        for _ in cast.enumerated().reversed() {
            cast.removeAll()
        }
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
    
    func markFavorite(_ show: ShowsResponse) {
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
    
    func markFavorite(_ showFromSchedule: ScheduleResponse) {
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
