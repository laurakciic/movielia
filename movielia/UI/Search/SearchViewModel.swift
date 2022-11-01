//
//  SearchViewModel.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    private let searchService: SearchServiceProtocol

    var subscription: Set<AnyCancellable> = []
    
    @Published var searchedShows = [SearchResponse]()
    @Published var searchText = String()
    
    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService
        
        $searchText
            // debounces the string publisher, such that it delays the process of sending request to remote server
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
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
}

