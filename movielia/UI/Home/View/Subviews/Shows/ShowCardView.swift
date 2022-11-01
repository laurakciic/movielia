//
//  MovieCardView.swift
//  movielia
//
//  Created by Laura on 20.10.2022..
//

import SwiftUI

struct ShowCardView: View {
    
    @ObservedObject var viewModel = HomeViewModel<Any>(showsService: ServiceFactory.showsService,
                                                       scheduleService: ServiceFactory.scheduleService,
                                                       castService: ServiceFactory.castService,
                                                       persistanceService: ServiceFactory.persistanceService)
    
    var show: ShowsResponse

    var body: some View {
        ZStack {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primaryDarkGray)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            
            VStack(alignment: .leading) {
                ZStack {
                    AsyncImage(url: show.image.medium) { image in
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
                                    viewModel.markFavorite(show)
                                    viewModel.persistChecked(viewModel.isShowSaved)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(viewModel.containsFavorite(show) ? Color.primaryYellow : Color.primaryLightGray)
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
                        
                        Text(String(show.rating.average ?? 0.0))
                            .foregroundColor(Color.primaryLightGray)
                            .font(.system(.callout))
                            .fontWeight(.light)
                    }
                    
                    Text(show.name)
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
