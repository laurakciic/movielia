//
//  ShowsView.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import SwiftUI

struct ShowsView: View {
    @ObservedObject var viewModel = HomeViewModel<Any>(showsService: ServiceFactory.showsService,
                                                       scheduleService: ServiceFactory.scheduleService,
                                                       castService: ServiceFactory.castService)
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
                    ForEach(viewModel.movies.prefix(10)) { movie in
                        ShowCardView(movie: movie)
                            .onTapGesture {
                                viewModel.fetchCast(movie.id)
                                viewModel.onGoToDetails?(movie, viewModel.cast)
                                let _ = print("Movie id: \(movie.id)")
//                                let _ = print("Movie cast: \(viewModel.cast)")
                            }
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
