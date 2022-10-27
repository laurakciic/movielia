//
//  HomeViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit

final class HomeViewModel<T>: ObservableObject {
    
    private let showsService: ShowsServiceProtocol
    private let scheduleService: ScheduleServiceProtocol
    private let castService: CastServiceProtocol
    
    var onGoToDetails: ((_ object: T, _ cast: [CastResponse]) -> Void)?
    
    @Published var movies = [ShowsResponse]()
    @Published var schedule = [ScheduleResponse]()
    @Published var cast = [CastResponse]()
    
    init(showsService: ShowsServiceProtocol, scheduleService: ScheduleServiceProtocol, castService: CastServiceProtocol) {
        self.showsService = showsService
        self.scheduleService = scheduleService
        self.castService = castService
    }
    
    func fetchMovieData() {
        self.showsService.fetchShows { result in
            switch(result) {
            case .success(let response):
                DispatchQueue.main.async {  self.movies.append(contentsOf: response)   }
                
            case .failure(let error):
                print("Error occured while fetching show data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchScheduleData() {
        scheduleService.fetchSchedule() { result in
            switch(result) {
            case .success(let response):
                DispatchQueue.main.async {  self.schedule.append(contentsOf: response)  }
                
            case .failure(let error):
                print("Error occured while fetching schedule data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCast(_ movie: Int) {
        castService.fetchCast(for: movie) { result in
            switch(result) {
            case .success(let response):
                DispatchQueue.main.async {
                    self.cast.append(contentsOf: response)
//                    print(self.cast)
                }
                
            case .failure(let error):
                print("Error occured while fetching cast data: \(error.localizedDescription)")
            }
        }
    }
}
