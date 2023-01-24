//
//  FavoritesViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import Foundation

final class FavoritesViewModel<T>: ObservableObject {
    
    private let persistanceService: PersistanceServiceProtocol
    private let castService:        CastServiceProtocol
    private let showsAPIResponse:   ShowsResponse
    
    @Published var shows         = [SearchResponse]()           // SEARCH?
    @Published var favoriteShows = [FavoriteData.Show]()
    @Published var cast          = [CastResponse]()
    @Published var isShowSaved   = Bool()
    
    var onGoToDetails: ((_ show: ShowsResponse, _ cast: [CastResponse]) -> Void)?
    
    init(persistanceService: PersistanceServiceProtocol, castService: CastServiceProtocol, showsAPIResponse: ShowsResponse) {
        self.persistanceService = persistanceService
        self.castService        = castService
        self.showsAPIResponse   = showsAPIResponse
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
    
//    func fetchShowOnClick(_ show: FavoriteData.Show) -> ShowsResponse {
//        return ShowsResponse(id: show.id, name: "", summary: show.summary, image: ShowsResponse.Image(medium: show.image, original: show.image), rating: ShowsResponse.Rating(average: 0.0))
//    }
    
    func fetchShowOnClick(_ show: FavoriteData.Show) -> ShowsResponse {
        let show = showsAPIResponse.createDataFromFavorites(show)
        return show
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
    
    func emptyActorsField(){
        for _ in shows.enumerated().reversed() {
            shows.removeAll()
        }
    }
}
