//
//  CastServiceProtocol.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import Foundation

protocol CastServiceProtocol: AnyObject {
    
    func fetchCast(for movie: Int, completionHandler: @escaping (Result<[CastResponse], Error>) -> Void)
    
}
