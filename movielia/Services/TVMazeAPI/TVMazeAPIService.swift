//
//  TvMazeAPIService.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

final class TVMazeAPIService: TVMazeAPIServiceProtocol {
    
    private let dataService: DataServiceProtocol = ServiceFactory.dataService
    
    init() { }
    
    func fetchMovieData(completionHandler: @escaping (Result<TVMazeAPIResponse, Error>) -> Void) {
        let url = URL(string: "https://api.tvmaze.com/shows/1")
        dataService.fetchJSON(from: url, completionHandler: completionHandler)
    }
}
