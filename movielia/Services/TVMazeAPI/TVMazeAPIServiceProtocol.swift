//
//  TvMazeAPIServiceProtocol.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

protocol TVMazeAPIServiceProtocol: AnyObject {
    
    func fetchMovieData(completionHandler: @escaping (Result<TVMazeAPIResponse, Error>) -> Void)
    
}
