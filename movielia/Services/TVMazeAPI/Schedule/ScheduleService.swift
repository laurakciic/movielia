//
//  ScheduleService.swift
//  movielia
//
//  Created by Laura on 20.10.2022..
//

import Foundation

final class ScheduleService: ScheduleServiceProtocol {
    
    private let dataService: DataServiceProtocol = ServiceFactory.dataService
    
    init() { }
    
    func fetchSchedule(completionHandler: @escaping (Result<[ScheduleResponse], Error>) -> Void) {
        // date in URL is optional - defaults o the current day
        guard let url = URL(string: "https://api.tvmaze.com/schedule?country=US") else {
            return completionHandler(.failure(ScheduleError.badURL))
        }
        
        dataService.fetchJSON(from: url, completionHandler: completionHandler)
    }
}
