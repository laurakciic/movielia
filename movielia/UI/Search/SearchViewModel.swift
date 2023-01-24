//
//  SearchViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import Foundation
import Combine

final class SearchViewModel<T>: ObservableObject {
    
    private let searchService: SearchServiceProtocol
    private let showsAPIResponse: ShowsResponse
    private let castService: CastServiceProtocol

    var onGoToDetails: ((_ show: ShowsResponse, _ cast: [CastResponse]) -> Void)?
    
    var subscription: Set<AnyCancellable> = []
    
    @Published var searchedShows = [SearchResponse]()
    @Published var searchText = String()
    @Published var cast = [CastResponse]()
    
    init(searchService: SearchServiceProtocol, showsAPIResponse: ShowsResponse, castService: CastServiceProtocol) {
        self.searchService = searchService
        self.showsAPIResponse = showsAPIResponse
        self.castService = castService
        
        $searchText
            // debounces the string publisher, such that it delays the process of sending request to remote server
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
        
            // prevents sending numerous requests and sends nil if the count of the characters is less than 1
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.searchedShows = []
                    return nil
                }
                
                return string
            })
            .compactMap{ $0 }   // removes the nil values so the search string does not get passed down to the publisher chain
            .sink{ (_) in
                //
            } receiveValue: { [self] (searchField) in
                fetchSearchData(for: searchField)
            }.store(in: &subscription)
    }
    
    func fetchSearchData(for show: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.searchService.fetchSearchResult(for: show) { result in
                
                DispatchQueue.main.async {
                    switch(result) {
                    case .success(let response):
                        self.searchedShows.insert(contentsOf: response, at: 0)
                        
                    case .failure(let error):
                        print("Error occured while fetching search data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
//    func fetchShowOnClick(_ show: SearchResponse) -> ShowsResponse {
//        return ShowsResponse(id: show.show.id, name: show.show.name, summary: show.show.summary ?? "", image: ShowsResponse.Image(medium: show.show.image?.medium, original: show.show.image?.original), rating: ShowsResponse.Rating(average: nil))
//    }
    
    func fetchShowOnClick(_ show: SearchResponse) -> ShowsResponse {
        let show = showsAPIResponse.createDataFromSearch(show)
        return show
    }
    
    func fetchCast(_ show: Int) {
        self.castService.fetchCast(for: show) { result in
            switch(result) {
            case .success(let response):
                let cast = response
                self.cast.insert(contentsOf: cast, at: 0)
                
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
}

