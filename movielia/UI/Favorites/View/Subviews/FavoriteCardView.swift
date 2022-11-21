//
//  FavoriteCardView.swift
//  movielia
//
//  Created by Laura on 01.11.2022..
//

import SwiftUI

struct FavoriteCardView: View {
    
    @ObservedObject var viewModel = FavoritesViewModel(persistanceService: ServiceFactory.persistanceService)
    var favorite: FavoriteData.Show
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: favorite.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
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
//                                viewModel.removeFavorite(favorite)
                                viewModel.toggleFavorite(favorite)
                                viewModel.persistChecked(viewModel.isShowSaved)
                            } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(viewModel.isInFavoritesArray(favorite) ? Color.primaryYellow : Color.primaryLightGray)
                                    .font(.title3)
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}
