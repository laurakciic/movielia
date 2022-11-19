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
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search shows", text: $viewModel.searchText)
                            .overlay(alignment: .trailing) {
                                Image(systemName: "xmark.circle.fill")
                                    .padding()
                                    .offset(x: 10)
                                    .foregroundColor(Color.primaryDarkGray)
                                    .opacity(viewModel.searchText.isEmpty ? 0 : 1)
                                    .onTapGesture {
                                        viewModel.searchText = ""
                                    }
                            }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.primaryWhite)
                    ).padding(10)
                    
                    if viewModel.searchedShows.count > 0 {
                        LazyVGrid(columns: layout, spacing: 12) {
                            ScrollView {
                                ForEach(viewModel.searchedShows, id: \.show.id) { show in
                                    SearchShowCardView(searchedShow: show)
                                }
                            }
                            .frame(height: UIScreen.main.bounds.height / 1.4)
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
