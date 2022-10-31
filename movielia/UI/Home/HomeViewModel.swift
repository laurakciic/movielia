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
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.showsService.fetchShows { result in
                
                DispatchQueue.main.async {
                    switch(result) {
                    case .success(let response):
                        self.movies.append(contentsOf: response)
                        
                    case .failure(let error):
                        print("Error occured while fetching show data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchScheduleData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.scheduleService.fetchSchedule() { result in
                DispatchQueue.main.async {
                    switch(result) {
                    case .success(let response):
                        self.schedule.append(contentsOf: response)
                        
                    case .failure(let error):
                        print("Error occured while fetching schedule data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchCastData(_ movie: Int) {
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let self = self else { return }

        self.castService.fetchCast(for: movie) { result in
//                DispatchQueue.main.async {
                    switch(result) {
                    case .success(let response):
                        self.cast.append(contentsOf: response)
                        
                    case .failure(let error):
                        print("Error occured while fetching cast data: \(error.localizedDescription)")
                    }
//                }
//            }
        }
    }
}
