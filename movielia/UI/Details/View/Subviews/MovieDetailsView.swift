//
//  MovieDetailsView.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

struct MovieDetailsView<T>: View {
        
    @ObservedObject var viewModel: DetailsViewModel<T>
    @Environment(\.dismiss) var dismiss

    var show: ShowsResponse
    var cast: [CastResponse]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack {
                    AsyncImage(url: show.image.original) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                    }
                    
                    VStack {
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height / 12)
                        
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                            .font(.system(.headline))
                            .font(.footnote.weight(.heavy))
                            .foregroundColor(Color.primaryWhite)
                            
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.primaryLightGray)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.primaryBlack))
                                    .frame(width: 40, height: 40)
                                
                                Button {
                                    viewModel.toggleFavorite(show)
                                    viewModel.persistChecked(viewModel.isSaved)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(viewModel.containsFavorite(show) ? Color.primaryYellow : Color.primaryLightGray)
                                        .font(.title3)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                Text(show.summaryWithoutHTMLTags)
                    .foregroundColor(Color.primaryLightGray)
                    .lineLimit(5)
                    .padding(.horizontal, 4)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("Cast")
                        .foregroundColor(Color.primaryLightGray)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        // show all cast
                    } label: {
                        Text("show all")
                            .foregroundColor(Color.primaryYellow)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(cast.prefix(10), id: \.person?.id) { person in
                            CastCardView(person: person)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .background(Color.primaryBlack)
        .ignoresSafeArea()
    }
}
