//
//  HomeViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit

final class HomeViewModel: ObservableObject {
    
    private let tvMazeAPIService: ShowsServiceProtocol
    @Published var movies = [ShowsResponse]()
    
    init(tvMazeAPIService: ShowsServiceProtocol) {
        self.tvMazeAPIService = tvMazeAPIService
    }
    
    func fetchMovieData() {
        tvMazeAPIService.fetchShows { result in
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
}
