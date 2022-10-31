//
//  SearchService.swift
//  movielia
//
//  Created by Laura on 29.10.2022..
//

import Foundation

final class SearchService: SearchServiceProtocol {
    
    private let dataService: DataServiceProtocol = ServiceFactory.dataService
    
    init() { }
    
    func fetchSearchResult(for searchQuery: String, completionHandler: @escaping (Result<[SearchResponse], Error>) -> Void) {
        guard let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(searchQuery)") else {
            return completionHandler(.failure(DataServiceError.badURL))
        }
        
        dataService.fetchJSON(from: url, completionHandler: completionHandler)
    }
}
