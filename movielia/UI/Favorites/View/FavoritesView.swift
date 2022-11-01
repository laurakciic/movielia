//
//  FavoritesView.swift
//  movielia
//
//  Created by Laura on 16.10.2022..
//

import SwiftUI

struct FavoritesView: View {
        
    @ObservedObject var viewModel: FavoritesViewModel
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.favoriteShows) { favorite in
                    FavoriteCardView(favorite: favorite)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding([.horizontal, .bottom])
            .task {
                viewModel.loadFavorites()
            }
        }
        .background(Color.primaryBlack)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: .init(persistanceService: PersistanceService()))
    }
}
