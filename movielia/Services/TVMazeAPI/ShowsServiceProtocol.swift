//
//  TvMazeAPIServiceProtocol.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

protocol ShowsServiceProtocol: AnyObject {
    
    func fetchShows(completionHandler: @escaping (Result<[ShowsResponse], Error>) -> Void)
    
}
