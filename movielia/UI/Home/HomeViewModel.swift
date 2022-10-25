//
//  HomeViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit

final class HomeViewModel: ObservableObject {
    
    private let showsService: ShowsServiceProtocol
    private let scheduleService: ScheduleServiceProtocol
    
    @Published var movies = [ShowsResponse]()
    @Published var schedule = [ScheduleResponse]()
    
    init(showsService: ShowsServiceProtocol, scheduleService: ScheduleServiceProtocol) {
        self.showsService = showsService
        self.scheduleService = scheduleService
    }
    
    func fetchMovieData() {
        self.showsService.fetchShows { result in
            switch(result) {
            case .success(let response):
                let movie = response
                DispatchQueue.main.async {  self.movies.append(contentsOf: movie)   }
                
            case .failure(let error):
                print("Error occured while fetching show data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchScheduleData() {
        scheduleService.fetchSchedule { result in
            switch(result) {
            case .success(let response):
                let schedule = response
                DispatchQueue.main.async {  self.schedule.append(contentsOf: schedule)  }
                
            case .failure(let error):
                print("Error occured while fetching schedule data: \(error.localizedDescription)")
            }
        }
    }
}
