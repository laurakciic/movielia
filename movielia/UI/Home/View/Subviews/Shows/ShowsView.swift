//
//  ShowsView.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import SwiftUI

struct ShowsView<T>: View {
    @ObservedObject var viewModel = HomeViewModel<Any>(showsService: ServiceFactory.showsService,
                                                       scheduleService: ServiceFactory.scheduleService,
                                                       castService: ServiceFactory.castService)
    
    var onGoToDetails: ((_ object: T, _ cast: [CastResponse]) -> Void)?
    
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
                                viewModel.fetchCastData(movie.id)
                                onGoToDetails?(movie as! T, viewModel.cast)
                            }
                    }
                }
            }
            .padding(.horizontal)
            .task {
                viewModel.fetchMovieData()
            }
        }
    }
}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsView<Any>()
    }
}
