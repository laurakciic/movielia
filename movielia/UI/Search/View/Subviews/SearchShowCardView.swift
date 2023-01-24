//
//  SearchShowCardView.swift
//  movielia
//
//  Created by Laura on 28.10.2022..
//

import SwiftUI

struct SearchShowCardView: View {
    
    var searchedShow: SearchResponse
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: searchedShow.show?.image?.medium) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(searchedShow.show?.name ?? "")
                    .foregroundColor(Color.primaryWhite)
                
                if ((searchedShow.show?.ended?.count ?? 0 > 0) && searchedShow.show?.yearPremiered != searchedShow.show?.yearEnded) {
                    Text("\(searchedShow.show!.yearPremiered)-\(searchedShow.show!.yearEnded)")
                        .foregroundColor(Color.primaryLightGray)
                } else {
                    Text(searchedShow.show?.yearPremiered ?? "")
                        .foregroundColor(Color.primaryLightGray)
                }
                
                HStack(spacing: 5) {
                    ForEach(searchedShow.show?.genres.prefix(3) ?? ["GASSSS"], id: \.self) { genre in
                        Text(genre)
                            .foregroundColor(Color.primaryLightGray)
                            .lineLimit(1)
                    }
                }
            }
            
            Spacer()
        }
    }
}
