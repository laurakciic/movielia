//
//  SearchView.swift
//  movielia
//
//  Created by Laura on 16.10.2022..
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel = SearchViewModel(searchService: ServiceFactory.searchService)
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
            ZStack {
                Image("TabBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height)
                    .opacity(viewModel.searchedShows.count > 0 ? 0.2 : 1)
                
                VStack {
                    HStack {
                        TextField("Search shows", text: $viewModel.searchText)
                            .padding(.horizontal, 40)
                            .frame(height: 45, alignment: .leading)
                            .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                            .clipped()
                            .cornerRadius(10)
                            .overlay {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                            }
                    }
                    
                    if viewModel.searchedShows.count > 0 {
                        LazyVGrid(columns: layout, spacing: 12) {
                            ScrollView {
                                ForEach(viewModel.searchedShows, id: \.show.id) { show in
                                    SearchShowCardView(searchedShow: show)
                                }
                            }
                            .frame(height: UIScreen.main.bounds.height / 1.3)
                        }
                    } else {
                        Spacer()
                    }
                }
                .padding(.vertical, 80).padding(.horizontal, 100)
            }
        .background(Color.primaryBlack)
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(searchService: ServiceFactory.searchService))
    }
}
