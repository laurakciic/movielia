//
//  CastService.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import Foundation

final class CastService: CastServiceProtocol {
    
    private let dataService: DataServiceProtocol = ServiceFactory.dataService
    
    func fetchCast(for movie: Int, completionHandler: @escaping (Result<[CastResponse], Error>) -> Void) {
        guard let url = URL(string: "https://api.tvmaze.com/shows/\(movie)/cast") else {
            return completionHandler(.failure(DataServiceError.badURL))
        }
        dataService.fetchJSON(from: url, completionHandler: completionHandler)
    }
}
