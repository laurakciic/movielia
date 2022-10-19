//
//  DataService.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import Foundation

final class DataService: DataServiceProtocol {
    
    func fetchJSON<T>(from url: URL?, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let url = url else {
            return completionHandler(.failure(DataServiceError.badURL))
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return completionHandler(.failure(DataServiceError.notConnectedToInternet))
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            return completionHandler(.failure(DataServiceError.badJSON))
        }

        completionHandler(.success(decodedData))
    }
    
}
