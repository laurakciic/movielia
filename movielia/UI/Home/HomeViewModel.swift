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
        showsService.fetchShows { result in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let response):
//                    let homeData = HomeData(data: response)
                    let movie = response
                    self.movies.append(contentsOf: movie)
                    //self.state = .showingData(homeData)

                case .failure(let error):
                    print("Error occured while fetching shows: \(error.localizedDescription)")
                    //self.state = .error(error)
                }
            }
        }
    }
    
    func fetchScheduleData() {
        scheduleService.fetchSchedule { result in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let response):
                    let schedule = response
                    self.schedule.append(contentsOf: schedule)
                    
                case .failure(let error):
                    print("Error occured while fetching schedule: \(error.localizedDescription)")
                }
            }
        }
    }
}
