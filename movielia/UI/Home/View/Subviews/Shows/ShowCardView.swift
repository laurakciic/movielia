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
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primaryDarkGray)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            
            VStack(alignment: .leading) {
                ZStack {
                    AsyncImage(url: movie.image.medium) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.bottom, 10)
                            .cornerRadius(10)
                            .padding(.bottom, -10)
                        
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    
                    VStack {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.primaryLightGray)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.primaryBlack))
                                    .frame(width: 35, height: 35)
                                
                                Button {
                                    // add show to Favorites
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color.primaryLightGray)
                                        .font(.title3)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
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
                        .padding(.vertical, 10)
                        .lineLimit(1)
                }
                .padding(.horizontal, 15)
            }
        }
    }
}
