//
//  SearchServiceProtocol.swift
//  movielia
//
//  Created by Laura on 29.10.2022..
//

import Foundation

protocol SearchServiceProtocol: AnyObject {
    
    func fetchSearchResult(for searchQuery: String, completionHandler: @escaping (Result<[SearchResponse], Error>) -> Void)
}
