//
//  ServiceFactory.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

enum ServiceFactory {
    
    static var dataService: DataServiceProtocol {
        DataService()
    }
    
    static var showsService: ShowsServiceProtocol {
        ShowsService()
    }
    
}
