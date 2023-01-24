//
//  TvMazeAPIResponse.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import Foundation

struct ShowsResponse: Identifiable, Codable {
    let id:      Int
    let name:    String
    var summary: String
    let premiered: String? // NOT NEEDED
    
    var summaryWithoutHTMLTags: String {
        return summary.removeHTMLTags()
    }
    
    let image: Image
    struct Image: Codable {
        let medium:   URL?
        let original: URL?
    }
    
    let rating: Rating
    struct Rating: Codable {
        let average: Double?
    }
    
    func createDataFromSearch(_ show: SearchResponse) -> ShowsResponse {
        return ShowsResponse(id: show.show?.id ?? 0, name: show.show?.name ?? "n/A", premiered: "", summary: show.show?.summary ?? "n/a", image: Image(medium: show.show?.image?.medium, original: show.show?.image?.original), rating: Rating(average: 0.0))
    }
    
    func createDataFromFavorites(_ show: FavoriteData.Show) -> ShowsResponse {
        return ShowsResponse(id: show.id, name: "", premiered: "", summary: show.summary, image: Image(medium: show.image, original: show.image), rating: Rating(average: 0.0))
    }
    
    // NOT NEEDED
    init(id: Int, name: String, premiered: String, summary: String, image: Image, rating: Rating) {
        self.id = id
        self.name = name
        self.summary = summary
        self.premiered = premiered
        self.image = image
        self.rating = rating
    }
    
    // FIX URL 
    static var defaultData: Self {
        ShowsResponse(id: 0, name: "", premiered: "", summary: "", image: Image(medium: URL(string: ""), original: URL(string: "")), rating: Rating(average: 0.0))
    }
}
