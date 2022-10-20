//
//  TvMazeAPIService.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

final class ShowsService: ShowsServiceProtocol {
    
    private let dataService: DataServiceProtocol = ServiceFactory.dataService
    
    init() { }
    
    func fetchShows(completionHandler: @escaping (Result<[ShowsResponse], Error>) -> Void) {
        guard let url = URL(string: "https://api.tvmaze.com/shows") else {
            return completionHandler(.failure(ShowsError.badURL))
        }
        dataService.fetchJSON(from: url, completionHandler: completionHandler)
    }
}
