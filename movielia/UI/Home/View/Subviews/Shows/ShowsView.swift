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
                                                       castService: ServiceFactory.castService,
                                                       persistanceService: ServiceFactory.persistanceService)
    
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
                    // show all shows
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
                    ForEach(viewModel.shows.prefix(10)) { show in
                        ShowCardView(show: show)
                            .onTapGesture {
                                viewModel.fetchCastData(show.id)
                                onGoToDetails?(show as! T, viewModel.cast)
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
