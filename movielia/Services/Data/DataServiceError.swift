//
//  DataServiceError.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import Foundation

enum DataServiceError: Error {
    case badURL
    case notConnectedToInternet
    case badJSON
}
