//
//  ShowsView.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import SwiftUI

struct ShowsView: View {
    @ObservedObject var viewModel = HomeViewModel(tvMazeAPIService: ShowsService())
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Shows")
                    .foregroundColor(Color.primaryLightGray)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Button {
                    // show all movies
                } label: {
                    Text("show all")
                        .foregroundColor(Color.primaryYellow)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(viewModel.movies.prefix(5), id: \.id) { movie in
                        ShowCardView(movie: movie)
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.fetchMovieData()
            }
        }
    }
}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsView()
    }
}
