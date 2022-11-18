//
//  MovieDetailsView.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

struct MovieDetailsView: View {
    
    var movie: ShowsResponse
    var cast: [CastResponse]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
                VStack {
                    AsyncImage(url: movie.image.original) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                    }
                                        
                    Text(movie.summaryWithoutHTMLTags)
                        .foregroundColor(Color.primaryLightGray)
                        .lineLimit(5)
                        .padding(.horizontal, 4)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("Cast")
                            .foregroundColor(Color.primaryLightGray)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            // show all cast
                        } label: {
                            Text("show all")
                                .foregroundColor(Color.primaryYellow)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(cast.prefix(10), id: \.person?.id) { person in
                                CastCardView(person: person)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
            .background(Color.primaryBlack)
            .ignoresSafeArea()
    }
}
