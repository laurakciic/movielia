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
        ScrollView {
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
                }.padding(.top, 10).padding(.horizontal, 20)
                
                
                if viewModel.searchedShows.count > 0 {
                    LazyVGrid(columns: layout, spacing: 12) {
                        ForEach(viewModel.searchedShows, id: \.show.id) { show in
                            SearchShowCardView(searchedShow: show)
                        }
                    }
                    .padding(.vertical, 5)
                } else {
                    VStack {
                        Image("Search")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .padding(.vertical, 10)
                        
                        Text("Search shows here.")
                            .foregroundColor(Color.primaryLightGray)
                            .font(.headline)
                            .fontWeight(.light)
                    }
                    .frame(height: UIScreen.main.bounds.height - 250)
                }
            }
        }
        .navigationBarHidden(true)
        .background(Color.primaryBlack)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(searchService: ServiceFactory.searchService))
    }
}
