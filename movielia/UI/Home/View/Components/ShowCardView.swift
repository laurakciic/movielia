//
//  MovieCardView.swift
//  movielia
//
//  Created by Laura on 20.10.2022..
//

import SwiftUI

struct ShowCardView: View {
    var movie: ShowsResponse
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primaryDarkGray)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            VStack(alignment: .leading) {
                AsyncImage(url: movie.image.medium) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.primaryDarkGray
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.primaryYellow)
                            .font(.system(.caption2))
                        
                        Text(String(movie.rating.average ?? 0.0))
                            .foregroundColor(Color.primaryLightGray)
                            .font(.system(.callout))
                            .fontWeight(.light)
                    }
                    
                    Text(movie.name)
                        .foregroundColor(Color.primaryLightGray)
                        .font(.system(.headline))
                        .fontWeight(.medium)
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
    }
}
