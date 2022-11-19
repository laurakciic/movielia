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
        ZStack {
            Image("TabBackground")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height)
                .opacity(viewModel.favoriteShows.count < 1 ? 0.5 : 0.2)
            
            VStack {
                Spacer()

                Text("No saved shows yet.")
                    .foregroundColor(Color.pink)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
                    .opacity(viewModel.favoriteShows.count < 1 ? 0.5 : 0)

                Spacer()
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.favoriteShows) { favorite in
                        FavoriteCardView(favorite: favorite)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
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
